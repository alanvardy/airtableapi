# frozen_string_literal: true

module UserSessionHelper
  def log_in(user)
    session[:user_id] = user.id
    session[:access] = user.permission.value
    session[:connected_sites] = user.sites.map(&:id)
  end

  def current_user
    User.find_by(id: session[:user_id])
  end
end
