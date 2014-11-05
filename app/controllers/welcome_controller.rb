class WelcomeController < ApplicationController
  def index
    @tenants = Tenant.all
    @posts = Post.where(published: true).paginate(page: params[:page], per_page: 10)
  end
end
