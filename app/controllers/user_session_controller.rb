# frozen_string_literal: true

class UserSessionController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      flash[:success] = 'You have logged in'
      log_in(user)
      redirect_to sites_index_path
    else
      flash[:danger] = 'Sorry, wrong credentials'
      redirect_to login_path
    end
  end

  def destroy
    reset_session
    flash[:success] = 'You have logged out'
    redirect_to root_path
  end
end
