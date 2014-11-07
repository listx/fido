class TenantsController < ApplicationController
  def index
    @tenants = tenants_sorted
    tenant_id = Tenant.find_by(name: params[:name]).id
    @posts = Post.where(published: true, tenant_id: tenant_id).paginate(page: params[:page], per_page: 10)
  end

  def show
  end
end
