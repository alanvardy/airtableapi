# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  def log_in(user)
    post login_path, params: { email: user.email, password: 'password' }
  end
end
