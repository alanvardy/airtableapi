# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  fixtures :all

  def log_in(user)
    post login_path, params: { email: user.email, password: 'password' }
  end

  def make_sites
    @site = Site.all.first
    @connection = Connection.create(user_id: users(:linked_client).id, site_id: @site.id)
  end
end
