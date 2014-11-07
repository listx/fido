class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper

  def tenants_sorted
    Tenant.all.sort { |a,b| a.name <=> b.name }
  end
end
