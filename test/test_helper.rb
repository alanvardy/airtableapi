# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  def log_in(user)
    post login_path, params: { email: user.email, password: 'password' }
  end

  def fill_db
    @p0 = Permission.create(title: 'Client', value: 0)
    @p1 = Permission.create(title: 'Technician', value: 1)
    @p2 = Permission.create(title: 'Manager', value: 2)
    @client = User.create(name: 'Client', email: 'client@a.com', password: 'password', password_confirmation: 'password', permission_id: @p0.id)
    @technician = User.create(name: 'Technician', email: 'technician@a.com', password: 'password', password_confirmation: 'password', permission_id: @p1.id)
    @manager = User.create(name: 'Manager', email: 'manager@a.com', password: 'password', password_confirmation: 'password', permission_id: @p2.id)

    @site = Site.all.first
    @connected_site = Site.all.last

    @connection = Connection.create(user_id: @client.id, site_id: @connected_site.id)
  end
end
