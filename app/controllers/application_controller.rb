# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include UserSessionHelper

  def check_access_level(num)
    reject_access unless access_level(num) || session[:admin]
  end

  def access_level(num)
    return false if session[:access].nil?

    session[:access] >= num
  end

  def reject_access
    flash[:danger] = 'Insufficient access level'
    if current_user.nil?
      redirect_to login_path
    else
      redirect_to current_user
    end
  end
end

def connected_site?(site_id)
  return false if session[:connected_sites].nil?

  session[:connected_sites].include? site_id
end
