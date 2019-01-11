# frozen_string_literal: true

require 'test_helper'

class PermissionsControllerTest < ActionDispatch::IntegrationTest

  test "shouldn't get index when not admin" do
    get permissions_url
    assert_redirected_to login_path

    log_in users(:client)
    get permissions_url
    assert_redirected_to user_path(users(:client))

    log_in users(:technician)
    get permissions_url
    assert_redirected_to user_path(users(:technician))

    log_in users(:manager)
    get permissions_url
    assert_redirected_to user_path(users(:manager))
  end

  test "shouldn't get new when not admin" do
    get new_permission_url
    assert_redirected_to login_path

    log_in users(:client)
    get new_permission_url
    assert_redirected_to user_path(users(:client))

    log_in users(:technician)
    get new_permission_url
    assert_redirected_to user_path(users(:technician))

    log_in users(:manager)
    get new_permission_url
    assert_redirected_to user_path(users(:manager))
  end

  test "shouldn't create permission when not admin" do
    assert_no_difference('Permission.count') do
      post permissions_url, params: { permission: { title: 'Pirate', value: 1 } }
    end
    assert_redirected_to login_path

    log_in users(:client)
    assert_no_difference('Permission.count') do
      post permissions_url, params: { permission: { title: 'Pirate', value: 1 } }
    end
    assert_redirected_to user_path(users(:client))

    log_in users(:technician)
    assert_no_difference('Permission.count') do
      post permissions_url, params: { permission: { title: 'Pirate', value: 1 } }
    end
    assert_redirected_to user_path(users(:technician))

    log_in users(:manager)
    assert_no_difference('Permission.count') do
      post permissions_url, params: { permission: { title: 'Pirate', value: 1 } }
    end
    assert_redirected_to user_path(users(:manager))
  end

  test "shouldn't show permission when not admin" do
    get permission_url(permissions(:p0))
    assert_redirected_to login_path

    log_in users(:client)
    get permission_url(permissions(:p0))
    assert_redirected_to user_path(users(:client))

    log_in users(:technician)
    get permission_url(permissions(:p0))
    assert_redirected_to user_path(users(:technician))

    log_in users(:manager)
    get permission_url(permissions(:p0))
    assert_redirected_to user_path(users(:manager))
  end

  test "shouldn't get edit when not admin" do
    get edit_permission_url(permissions(:p0))
    assert_redirected_to login_path

    log_in users(:client)
    get edit_permission_url(permissions(:p0))
    assert_redirected_to user_path(users(:client))

    log_in users(:technician)
    get edit_permission_url(permissions(:p0))
    assert_redirected_to user_path(users(:technician))

    log_in users(:manager)
    get edit_permission_url(permissions(:p0))
    assert_redirected_to user_path(users(:manager))
  end

  test "shouldn't update permission when not admin" do
    patch permission_url(permissions(:p0)), params: { permission: { title: permissions(:p0).title, value: permissions(:p0).value } }
    assert_redirected_to login_path

    log_in users(:client)
    patch permission_url(permissions(:p0)), params: { permission: { title: permissions(:p0).title, value: permissions(:p0).value } }
    assert_redirected_to user_path(users(:client))

    log_in users(:technician)
    patch permission_url(permissions(:p0)), params: { permission: { title: permissions(:p0).title, value: permissions(:p0).value } }
    assert_redirected_to user_path(users(:technician))

    log_in users(:manager)
    patch permission_url(permissions(:p0)), params: { permission: { title: permissions(:p0).title, value: permissions(:p0).value } }
    assert_redirected_to user_path(users(:manager))
  end

  test "shouldn't destroy permission when not admin" do
    assert_no_difference('Permission.count') do
      delete permission_url(permissions(:p0))
    end
    assert_redirected_to login_path

    log_in users(:client)
    assert_no_difference('Permission.count') do
      delete permission_url(permissions(:p0))
    end
    assert_redirected_to user_path(users(:client))

    log_in users(:technician)
    assert_no_difference('Permission.count') do
      delete permission_url(permissions(:p0))
    end
    assert_redirected_to user_path(users(:technician))

    log_in users(:manager)
    assert_no_difference('Permission.count') do
      delete permission_url(permissions(:p0))
    end
    assert_redirected_to user_path(users(:manager))
  end
end
