require 'net/http'

class Site < ActiveRecord::Base

  has_many :site_healths, dependent: :destroy
  has_many :content_tests, dependent: :destroy
  belongs_to :user

  validates :name, presence: true
  validates :url, presence: true

  after_save :check!

  scope :active, ->{ where(active: true) }

  def check!
    start_time = Time.now
    response = http_get(url)
    finish_time = Time.now
    site_health = site_healths.create({
      http_response: response.code.to_i,
      response_time: ((finish_time.to_f - start_time.to_f) * 1000.0).to_i
    })
  end

  def fetch
    @content ||= http_get(url).body
  end

  def latest_status
    main_test_passes = site_healths.most_recent.http_response == 200 
    content_test_failing = content_tests.active.collect(&:current_status).include?("Test failed")
    if content_test_failing && main_test_passes
      "warning"
    else
      main_test_passes ? "ok" : "error"
    end
  end

  private

  def http_get(http_url)
    uri = URI.parse(http_url)
    request = Net::HTTP::Get.new(uri.to_s)
    http = Net::HTTP.new(uri.host, uri.port)
    if uri.scheme == "https"
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE # read into this
    end
    http.get(uri.request_uri)
  end

end
