# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  def log_in(user)
    post login_path, params: { email: user.email, password: 'password' }
  end

  def create_client
    @permission = Permission.create(title: 'Client', value: 0)
    @client = User.create(name: 'client', email: 'client@client.com', password: 'password', password_confirmation: 'password', permission_id: Permission.first.id)
    @connection = Connection.create(user_id: 1, site_id: 'xxx')
    log_in(@client)
    @client
  end

  def create_manager
    @permission = Permission.create(title: 'Manager', value: 2)
    @manager = User.create(name: 'manager', email: 'manager@manager.com', password: 'password', password_confirmation: 'password', permission_id: Permission.first.id)
    @connection = Connection.create(user_id: 1, site_id: 'xxx')
    log_in(@manager)
    @manager
  end
end
