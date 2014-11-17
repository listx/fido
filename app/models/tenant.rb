class Tenant
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  # We have to manually implement our own 'has_many :users' declaration, because
  # the 'User' model is kept by activerecord in postgres, not mongodb. Also,
  # Mongodb uses the "_id" attribute, which is the analogue to RBDMS's primaryr
  # key which AR sets to the "id" attribute.
  def users
    User.where(tenant_oid: self._id)
  end
end
