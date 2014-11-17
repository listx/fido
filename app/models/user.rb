class User < ActiveRecord::Base
  validates :name,
    presence: true,
    length: {minimum: 2, maximum: 20},
    uniqueness: {case_sensitive: false}
  has_secure_password
  belongs_to :role
  belongs_to :tenant
  has_objectid_columns

  # We write a method to simulate the AR 'belongs_to tenant' declaration
  def tenant
    Tenant.find(self.tenant_oid)
  end

  # Simulate 'has_many :posts'.
  def posts
    Post.where(self.user_id)
  end
end
