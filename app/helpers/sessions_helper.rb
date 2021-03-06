module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def current_user?(user)
    user == current_user
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def admin_user
    if admin_user?
    else
      redirect_to root_url
    end
  end

  def admin_user?
    Rails.env.development? || \
    (Role.find_by(id: current_user.role_id).description == "site_admin")
  end

  def logged_in_user
    if !logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
