class ContentTest < ActiveRecord::Base

  belongs_to :site
  has_many :test_statuses

  validates :comparison, presence: true
  validates :content, presence: true
  validates :content, uniqueness: { scope: :comparison }

  after_save :check!

  def self.comparisons
    ["matches", "doesn't match"]
  end

  def current_status
    latest = test_statuses.latest
    if latest
      latest.result ? "OK" : "Content not found"
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
  end

end
