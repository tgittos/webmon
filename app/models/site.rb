require 'net/http'

class Site < ActiveRecord::Base

  has_many :tests, dependent: :destroy
  belongs_to :user

  validates :name, presence: true
  validates :url, presence: true, uniquness: { scope: :user_id }

  scope :active, ->{ where(active: true) }

  def fetch
    http_get(url)
  end

  def fetch_body
    fetch.body
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
