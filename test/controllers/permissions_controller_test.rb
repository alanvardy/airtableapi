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

  test 'should get index when admin' do
    log_in_admin
    get permissions_path
    assert_response :success
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

  test 'should get new when admin' do
    log_in_admin
    get new_permission_url
    assert_response :success
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

  test 'should create permission when admin' do
    log_in_admin
    assert_difference('Permission.count') do
      post permissions_url, params: { permission: { title: 'Pirate', value: 1 } }
    end
    assert_redirected_to Permission.last
  end
  test 'shouldn\'t create permission when admin if bad values' do
    log_in_admin
    assert_no_difference('Permission.count') do
      post permissions_url, params: { permission: { value: 1 } }
    end
    assert_no_difference('Permission.count') do
      post permissions_url, params: { permission: { title: 'Pirate' } }
    end
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

  test 'should show permission when admin' do
    log_in_admin
    get permission_url(permissions(:p0))
    assert_response :success
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

  test 'should get edit when admin' do
    log_in_admin
    get edit_permission_url(permissions(:p0))
    assert_response :success
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

  test 'should update permission when admin' do
    log_in_admin
    patch permission_url(permissions(:p0)), params: { permission: { title: permissions(:p0).title, value: permissions(:p0).value } }
    assert_redirected_to permissions(:p0)
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

  test 'should destroy permission when admin' do
    log_in_admin
    assert_difference('Permission.count', -1) do
      delete permission_url(permissions(:p0))
    end
    assert_redirected_to permissions_path
  end
end
