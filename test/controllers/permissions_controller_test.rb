# frozen_string_literal: true

require 'test_helper'

class PermissionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    fill_db
  end

  test "shouldn't get index when not admin" do
    get permissions_url
    assert_redirected_to login_path

    log_in @client
    get permissions_url
    assert_redirected_to user_path(@client)

    log_in @technician
    get permissions_url
    assert_redirected_to user_path(@technician)

    log_in @manager
    get permissions_url
    assert_redirected_to user_path(@manager)
  end

  test "shouldn't get new when not admin" do
    get new_permission_url
    assert_redirected_to login_path

    log_in @client
    get new_permission_url
    assert_redirected_to user_path(@client)

    log_in @technician
    get new_permission_url
    assert_redirected_to user_path(@technician)

    log_in @manager
    get new_permission_url
    assert_redirected_to user_path(@manager)
  end

  test "shouldn't create permission when not admin" do
    assert_no_difference('Permission.count') do
      post permissions_url, params: { permission: { title: 'Pirate', value: 1 } }
    end
    assert_redirected_to login_path

    log_in @client
    assert_no_difference('Permission.count') do
      post permissions_url, params: { permission: { title: 'Pirate', value: 1 } }
    end
    assert_redirected_to user_path(@client)

    log_in @technician
    assert_no_difference('Permission.count') do
      post permissions_url, params: { permission: { title: 'Pirate', value: 1 } }
    end
    assert_redirected_to user_path(@technician)

    log_in @manager
    assert_no_difference('Permission.count') do
      post permissions_url, params: { permission: { title: 'Pirate', value: 1 } }
    end
    assert_redirected_to user_path(@manager)
  end

  test "shouldn't show permission when not admin" do
    get permission_url(@p0)
    assert_redirected_to login_path

    log_in @client
    get permission_url(@p0)
    assert_redirected_to user_path(@client)

    log_in @technician
    get permission_url(@p0)
    assert_redirected_to user_path(@technician)

    log_in @manager
    get permission_url(@p0)
    assert_redirected_to user_path(@manager)
  end

  test "shouldn't get edit when not admin" do
    get edit_permission_url(@p0)
    assert_redirected_to login_path

    log_in @client
    get edit_permission_url(@p0)
    assert_redirected_to user_path(@client)

    log_in @technician
    get edit_permission_url(@p0)
    assert_redirected_to user_path(@technician)

    log_in @manager
    get edit_permission_url(@p0)
    assert_redirected_to user_path(@manager)
  end

  test "shouldn't update permission when not admin" do
    patch permission_url(@p0), params: { permission: { title: @p0.title, value: @p0.value } }
    assert_redirected_to login_path

    log_in @client
    patch permission_url(@p0), params: { permission: { title: @p0.title, value: @p0.value } }
    assert_redirected_to user_path(@client)

    log_in @technician
    patch permission_url(@p0), params: { permission: { title: @p0.title, value: @p0.value } }
    assert_redirected_to user_path(@technician)

    log_in @manager
    patch permission_url(@p0), params: { permission: { title: @p0.title, value: @p0.value } }
    assert_redirected_to user_path(@manager)
  end

  test "shouldn't destroy permission when not admin" do
    assert_no_difference('Permission.count') do
      delete permission_url(@p0)
    end
    assert_redirected_to login_path

    log_in @client
    assert_no_difference('Permission.count') do
      delete permission_url(@p0)
    end
    assert_redirected_to user_path(@client)

    log_in @technician
    assert_no_difference('Permission.count') do
      delete permission_url(@p0)
    end
    assert_redirected_to user_path(@technician)

    log_in @manager
    assert_no_difference('Permission.count') do
      delete permission_url(@p0)
    end
    assert_redirected_to user_path(@manager)
  end
end
