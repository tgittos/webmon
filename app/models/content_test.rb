class ContentTest < ActiveRecord::Base

  belongs_to :site
  has_many :test_statuses, dependent: :destroy

  validates :comparison, presence: true
  validates :content, presence: true
  validates :content, uniqueness: { scope: :comparison }

  after_save :check!

  scope :active, ->{ where(active: true) }

  def self.comparisons
    ["matches", "doesn't match"]
  end

  def to_s
    "#{comparison} \"#{content}\""
  end

  def latest_status
    test_statuses.latest.result ? "ok" : "error"
  end

  def current_status
    latest = test_statuses.latest
    if latest
      latest.result ? "OK" : "Test failed"
    else
      "Test not run yet"
    end
  end

  def check!
    test_status = test_statuses.new
    page_content = site.fetch
    test_status.result = !if self.comparison == "matches"
      page_content =~ /#{content}/
    else
      page_content !~ /#{content}/
    end == false
    test_status.save!
    test_status
  end

end
