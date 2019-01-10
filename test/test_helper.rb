# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  fixtures :all

  def log_in(user)
    post login_path, params: { email: user.email, password: 'password' }
  end

  def fill_db
    @site = Site.all.first
    @connected_site = Site.all.last

    @connection = Connection.create(user_id: users(:client).id, site_id: @connected_site.id)
  end
end
