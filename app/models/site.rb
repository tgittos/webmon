class Site < ActiveRecord::Base

  validates :name, presence: true
  validates :url, presence: true

end
