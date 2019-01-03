# frozen_string_literal: true

module UserSessionHelper
  def log_in(user)
    session[:user_id] = user.id
    session[:access] = current_user.permission.value
  end

  def current_user
    User.find_by(id: session[:user_id])
  end
end
