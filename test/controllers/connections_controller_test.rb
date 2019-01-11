# frozen_string_literal: true

require 'test_helper'

class ConnectionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    make_sites
  end
  
  test "shouldn't get index when not logged in" do
    get connections_url
    assert_redirected_to login_path
  end

  test "shouldn't get index when insufficient permissions" do
    log_in users(:client)
    get connections_url
    assert_redirected_to user_path(users(:client))
    log_in users(:technician)
    get connections_url
    assert_redirected_to user_path(users(:technician))
  end

  test 'should get index when sufficient permissions' do
    log_in users(:manager)
    get connections_url
    assert_response :success
  end

  test "shouldn't get new when not logged in" do
    get new_connection_url
    assert_redirected_to login_path
  end

  test "shouldn't get new when insufficient access permissions" do
    log_in users(:client)
    get new_connection_url
    assert_redirected_to user_path(users(:client))
    log_in users(:technician)
    get new_connection_url
    assert_redirected_to user_path(users(:technician))
  end

  test 'should get new when sufficient access permissions' do
    log_in users(:manager)
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
    log_in users(:client)
    assert_no_difference('Connection.count') do
      post connections_url, params: { connection: { site_id: @connection.site_id, user_id: @connection.user_id } }
    end
    assert_redirected_to user_path(users(:client))
    log_in users(:technician)
    assert_no_difference('Connection.count') do
      post connections_url, params: { connection: { site_id: @connection.site_id, user_id: @connection.user_id } }
    end
    assert_redirected_to user_path(users(:technician))
  end

  test 'should create connection when sufficient access permissions' do
    log_in users(:manager)
    assert_difference('Connection.count') do
      post connections_url, params: { connection: { site_id: @site.id, user_id: users(:client).id } }
    end

    assert_redirected_to connection_url(Connection.last)
  end

  test "shouldn't show connection when not logged in" do
    get connection_url(@connection)
    assert_redirected_to login_path
  end

  test "shouldn't show connection when insufficient access permissions" do
    log_in users(:client)
    get connection_url(@connection)
    assert_redirected_to user_path(users(:client))
    log_in users(:technician)
    get connection_url(@connection)
    assert_redirected_to user_path(users(:technician))
  end

  test 'should show connection when when sufficient access permissions' do
    log_in users(:manager)
    get connection_url(@connection)
    assert_response :success
  end

  test "shouldn't get edit when not logged in" do
    get edit_connection_url(@connection)
    assert_redirected_to login_path
  end

  test "shouldn't get edit when not insufficient access permissions" do
    log_in users(:client)
    get edit_connection_url(@connection)
    assert_redirected_to user_path(users(:client))
    log_in users(:technician)
    get edit_connection_url(@connection)
    assert_redirected_to user_path(users(:technician))
  end

  test 'should get edit when sufficient access permissions' do
    log_in users(:manager)
    get edit_connection_url(@connection)
    assert_response :success
  end

  test "shouldn't update connection when not logged in" do
    patch connection_url(@connection), params: { connection: { site_id: @connection.site_id, user_id: @connection.user_id } }
    assert_redirected_to login_path
  end

  test "shouldn't update connection when insufficient permissions" do
    log_in users(:client)
    patch connection_url(@connection), params: { connection: { site_id: @connection.site_id, user_id: @connection.user_id } }
    assert_redirected_to user_path(users(:client))
    log_in users(:technician)
    patch connection_url(@connection), params: { connection: { site_id: @connection.site_id, user_id: @connection.user_id } }
    assert_redirected_to user_path(users(:technician))
  end

  test 'should update connection when sufficient permissions' do
    log_in users(:manager)
    patch connection_url(@connection), params: { connection: { site_id: @connection.site_id, user_id: @connection.user_id } }
    assert_redirected_to connection_url(@connection)
  end

  test "shouldn't destroy connection when not logged in" do
    assert_no_difference('Connection.count', -1) do
      delete connection_url(@connection)
    end

    assert_redirected_to login_path
  end
  test "shouldn't destroy connection when insufficient permissions" do
    log_in users(:client)
    assert_no_difference('Connection.count', -1) do
      delete connection_url(@connection)
    end

    assert_redirected_to user_path(users(:client))
    log_in users(:technician)
    assert_no_difference('Connection.count', -1) do
      delete connection_url(@connection)
    end

    assert_redirected_to user_path(users(:technician))
  end
  test 'should destroy connection when sufficient permissions' do
    log_in users(:manager)
    assert_difference('Connection.count', -1) do
      delete connection_url(@connection)
    end

    assert_redirected_to connections_url
  end
end
