# frozen_string_literal: true

require 'test_helper'

class ConnectionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    # @permission = Permission.create(title: 'Client', value: 0)
    # @client = User.create(name: 'client', email: 'client@client.com', password: 'password', password_confirmation: 'password', permission_id: 1)
    # @connection = Connection.create(user_id: 1, site_id: 'xxx')
  end

  # test "shouldn't get index when not logged in" do
  #   get connections_url
  #   assert_redirected_to login_path
  # end

  test "shouldn't get new when not logged in" do
    get new_connection_url
    assert_redirected_to login_path
  end

  test "shouldn't get new when insufficient access permissions" do
    @client = create_client
    get new_connection_url
    assert_redirected_to user_path(@client)
  end

  test 'should get new when sufficient access permissions' do
    create_manager
    get new_connection_url
    assert_response :success
  end

  # test "should create connection" do
  #   assert_difference('Connection.count') do
  #     post connections_url, params: { connection: { sites_id: @connection.sites_id, users_id: @connection.users_id } }
  #   end

  #   assert_redirected_to connection_url(Connection.last)
  # end

  # test "should show connection" do
  #   get connection_url(@connection)
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get edit_connection_url(@connection)
  #   assert_response :success
  # end

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
