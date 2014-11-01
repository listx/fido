class User < ActiveRecord::Base
  validates :name,
    presence: true,
    length: {minimum: 2, maximum: 20},
    uniqueness: {case_sensitive: false}
  has_secure_password
  belongs_to :role
  has_many :posts
  before_save :default_values

  ROLE_AUTHOR = 2

  def default_values
    self.role_id ||= ROLE_AUTHOR
  end
end
