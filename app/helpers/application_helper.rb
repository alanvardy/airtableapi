# frozen_string_literal: true

module ApplicationHelper
  def admin?
    session[:admin]
  end

  def access_level(num)
    return false if session[:access].nil?

    session[:access] >= num
  end

  def table_large
    'd-none d-lg-table-cell'
  end

  def table_small
    'd-table-cell d-lg-none'
  end
end
