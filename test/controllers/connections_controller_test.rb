# frozen_string_literal: true

require 'test_helper'

class ConnectionsControllerTest < ActionDispatch::IntegrationTest
  setup do
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

  test "shouldn't get index when not logged in" do
    get connections_url
    assert_redirected_to login_path
  end

  test "shouldn't get index when insufficient permissions" do
    log_in @client
    get connections_url
    assert_redirected_to user_path(@client)
    log_in @technician
    get connections_url
    assert_redirected_to user_path(@technician)
  end

  test 'should get index when sufficient permissions' do
    log_in @manager
    get connections_url
    assert_response :success
  end

  test "shouldn't get new when not logged in" do
    get new_connection_url
    assert_redirected_to login_path
  end

  test "shouldn't get new when insufficient access permissions" do
    log_in @client
    get new_connection_url
    assert_redirected_to user_path(@client)
    log_in @technician
    get new_connection_url
    assert_redirected_to user_path(@technician)
  end

  test 'should get new when sufficient access permissions' do
    log_in @manager
    get new_connection_url
    assert_response :success
  end

  test "shouldn't create connection when not logged in" do
    assert_no_difference('Connection.count') do
      post connections_url, params: { connection: { site_id: @connection.site_id, user_id: @connection.user_id } }
    end

    assert_redirected_to login_path
  end

  test "shouldn't create connection when insufficient access permissions" do
    log_in @client
    assert_no_difference('Connection.count') do
      post connections_url, params: { connection: { site_id: @connection.site_id, user_id: @connection.user_id } }
    end
    assert_redirected_to user_path(@client)
    log_in @technician
    assert_no_difference('Connection.count') do
      post connections_url, params: { connection: { site_id: @connection.site_id, user_id: @connection.user_id } }
    end
    assert_redirected_to user_path(@technician)
  end

  test 'should create connection when sufficient access permissions' do
    log_in @manager
    assert_difference('Connection.count') do
      post connections_url, params: { connection: { site_id: @site.id, user_id: @client.id } }
    end

    assert_redirected_to connection_url(Connection.last)
  end

  test "shouldn't show connection when not logged in" do
    get connection_url(@connection)
    assert_redirected_to login_path
  end

  test "shouldn't show connection when insufficient access permissions" do
    log_in @client
    get connection_url(@connection)
    assert_redirected_to user_path(@client)
    log_in @technician
    get connection_url(@connection)
    assert_redirected_to user_path(@technician)
  end

  test 'should show connection when when sufficient access permissions' do
    log_in @manager
    get connection_url(@connection)
    assert_response :success
  end

  test "shouldn't get edit when not logged in" do
    get edit_connection_url(@connection)
    assert_redirected_to login_path
  end

  test "shouldn't get edit when not insufficient access permissions" do
    log_in @client
    get edit_connection_url(@connection)
    assert_redirected_to user_path(@client)
    log_in @technician
    get edit_connection_url(@connection)
    assert_redirected_to user_path(@technician)
  end

  test 'should get edit when sufficient access permissions' do
    log_in @manager
    get edit_connection_url(@connection)
    assert_response :success
  end

  # test "should update connection" do
  #   patch connection_url(@connection), params: { connection: { sites_id: @connection.sites_id, users_id: @connection.users_id } }
  #   assert_redirected_to connection_url(@connection)
  # end

  # test "should destroy connection" do
  #   assert_difference('Connection.count', -1) do
  #     delete connection_url(@connection)
  #   end

  #   assert_redirected_to connections_url
  # end
end
