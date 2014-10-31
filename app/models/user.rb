class User < ActiveRecord::Base
  validates :name,
    presence: true,
    length: {minimum: 2, maximum: 20},
    uniqueness: {case_sensitive: false}
  has_secure_password
end
