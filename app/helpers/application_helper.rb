# frozen_string_literal: true

module ApplicationHelper
  def admin?
    session[:admin]
  end

  def access_level(num)
    return false if session[:access].nil?

    session[:access] >= num
  end
end
