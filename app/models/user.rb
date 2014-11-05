class User < ActiveRecord::Base
  validates :name,
    presence: true,
    length: {minimum: 2, maximum: 20},
    uniqueness: {case_sensitive: false}
  has_secure_password
  belongs_to :role
  belongs_to :tenant
  has_many :posts
end
