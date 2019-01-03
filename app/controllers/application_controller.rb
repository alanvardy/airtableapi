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

  def authentication_required!
    session[:admin] || raise(ApplicationNotAuthenticated)
  end

  def access_level(num)
    return false if session[:access].nil?

    session[:access] >= num
  end
end
