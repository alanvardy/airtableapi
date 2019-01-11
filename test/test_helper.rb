# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  fixtures :all

  def log_in(user)
    post login_path, params: { email: user.email, password: 'password' }
  end

  def log_in_admin
    post session_create_path, params: { admin: { username: ENV['ADMIN_USERNAME'], password: ENV['ADMIN_PASS'] } }
  end

  def load_airtable_objects
    @site = Site.all.first
    @connection = Connection.create(user_id: users(:linked_client).id, site_id: @site.id)
    @equipment = @site.equipment.first
  end
end
