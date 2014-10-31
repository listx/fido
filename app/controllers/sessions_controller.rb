class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by(name: params[:session][:name].downcase)
    # User model's 'has_secure_password' gives us the '#authenticate' method.
    if !user.nil? && user.authenticate(params[:session][:password])
      # Log in and redirect to the user's dashboard page.
    else
      # Create an error message.
      flash.now[:danger] = "Invalid username/password combination."
      # Redirect back to the login page again.
      render 'new'
    end
  end
  def destroy
  end
end
