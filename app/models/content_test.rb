class ContentTest < ActiveRecord::Base

  belongs_to :site

  validates :comparison, presence: true
  validates :content, presence: true
  validates :content, uniqueness: { scope: :comparison }

  def self.comparisons
    ["matches", "doesn't match"]
  end

end
