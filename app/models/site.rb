require 'net/http'

class Site < ActiveRecord::Base

  has_many :site_healths
  has_many :content_tests

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

  private

  def http_get(http_url)
    uri = URI.parse(http_url)
    request = Net::HTTP::Get.new(uri.to_s)
    Net::HTTP.start(uri.host, uri.port) {|http|
      http.request(request)
    }
  end

end
