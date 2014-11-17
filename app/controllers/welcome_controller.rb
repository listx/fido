class WelcomeController < ApplicationController
  def index
    @tenants = tenants_sorted
    @posts = Post.where(published: true).page(params[:page]).per(10)
  end
end
