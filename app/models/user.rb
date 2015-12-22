class User < ActiveRecord::Base

  validates :app_uid, presence: true
  validates :email, presence: true
  validates :email, uniqueness: { scope: :app_uid }

  has_many :sites, dependent: :destroy
end
