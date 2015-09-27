class SiteHealth < ActiveRecord::Base
  belongs_to :site

  scope :most_recent, ->{ order('created_at DESC').first }
end
