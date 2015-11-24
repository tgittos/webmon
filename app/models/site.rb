require 'net/http'

class Site < ActiveRecord::Base

  has_many :tests, dependent: :destroy
  belongs_to :user

  validates :name, presence: true
  validates :url, presence: true, uniqueness: { scope: :user_id }
  validate :can_reach_url

  before_validation :add_missing_url_scheme

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

  def can_reach_url
    begin
      http_get(url)
    rescue Exception => e
      Rails.logger.debug("#{e.message}\n\t#{e.backtrace.join("\n\t")}")
      errors.add(:url, "can't be reached from URL Up")
    end
  end

  def add_missing_url_scheme
    self.url = "http://#{self.url}" if self.url !~ /https?:\/\//
  end

end
