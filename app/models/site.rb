class Site < ActiveRecord::Base

  validates :name, presence: true
  validates :url, presence: true

  scope :active, ->{ where(active: true) }

end
