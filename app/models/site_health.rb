class SiteHealth < ActiveRecord::Base
  belongs_to :site

  scope :newest_first, -> { order('created_at DESC') }
  scope :most_recent, ->{ newest_first.first }
end
