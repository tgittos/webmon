require 'net/http'

class Site < ActiveRecord::Base

  has_many :tests, dependent: :destroy
  belongs_to :user

  validates :name, presence: true
  validates :url, presence: true

  scope :active, ->{ where(active: true) }

  def fetch
    @response ||= http_get(url)
  end

  def fetch_body
    @content ||= fetch.body
  end

  def latest_status
    # check if the latest result of any test is a failure
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
