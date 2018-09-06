class User < ActiveRecord::Base
  has_secure_password
  has_many :lists
  has_many :tasks, through: :lists
end
