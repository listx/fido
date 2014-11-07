class WelcomeController < ApplicationController
  def index
    @tenants = tenants_sorted
    @posts = Post.where(published: true).paginate(page: params[:page], per_page: 10)
  end
end
