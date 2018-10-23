class User < ActiveRecord::Base
  has_secure_password
  has_many :lists
  has_many :tasks, through: :lists
  validates_uniqueness_of :username
  validates :username, presence: true
  validates :password, presence: true
end
