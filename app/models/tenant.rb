class Tenant < ActiveRecord::Base
  has_many :users
end
