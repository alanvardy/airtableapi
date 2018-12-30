# frozen_string_literal: true

class UserSessionController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      flash[:success] = 'You have logged in'
      log_in(user)
      redirect_to user
    else
      flash[:notice] = 'Sorry, wrong credentials'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'You have logged out'
    redirect_to root_path
  end
end
