# frozen_string_literal: true

module ApplicationHelper
  def admin?
    session[:admin]
  end
end
