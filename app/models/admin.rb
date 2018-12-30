# frozen_string_literal: true

# admin.rb

class Admin
  include ActiveModel::Model
  attr_accessor :username, :password

  def login_valid?
    @username == ENV['ADMIN_USERNAME'] && @password == ENV['ADMIN_PASS']
  end
end
