class WelcomeController < ApplicationController
  def index
    @tenants = Tenant.all.sort { |a,b| a.name <=> b.name }
    @posts = Post.where(published: true).paginate(page: params[:page], per_page: 10)
  end
end
