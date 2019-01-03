# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include UserSessionHelper

  ApplicationNotAuthenticated = Class.new(StandardError)

  rescue_from ApplicationNotAuthenticated do
    respond_to do |format|
      format.json { render json: { errors: [message: '401 Not Authorized'] }, status: 401 }
      format.html do
        flash[:notice] = 'Not Authorized to access this page, please log in'
        redirect_to new_session_path
      end
      format.any { head 401 }
    end
  end

  def check_admin
    session[:admin] || raise(ApplicationNotAuthenticated)
  end

  def check_access_level(num)
    reject_access unless access_level num
  end

  def access_level(num)
    return false if session[:access].nil?

    session[:access] >= num
  end

  def reject_access
    flash[:danger] = 'Insufficient access level'
    redirect_to current_user
  end
end

def connected_site?(site_id)
  current_user.sites.map(&:id).include? site_id
end
