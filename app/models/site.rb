class Site < ActiveRecord::Base

  has_many :site_healths

  validates :name, presence: true
  validates :url, presence: true

  scope :active, ->{ where(active: true) }

end
