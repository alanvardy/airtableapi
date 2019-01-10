# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'shouldn\'t get index when not logged in' do
    get users_url
    assert_redirected_to login_path
  end

  test 'shouldn\'t get index when insufficient permissions' do
    log_in users(:client)
    get users_url
    assert_redirected_to user_path(users(:client))
    log_in users(:technician)
    get users_url
    assert_redirected_to user_path(users(:technician))
  end

  test 'should get index when sufficient permissions' do
    log_in users(:manager)
    get users_url
    assert_response :success
  end

  test 'shouldn\'t get new when not logged in' do
    get new_user_path
    assert_redirected_to login_path
  end

  test 'shouldn\'t get new when insufficient permissions' do
    log_in users(:client)
    get new_user_path
    assert_redirected_to user_path(users(:client))
    log_in users(:technician)
    get new_user_path
    assert_redirected_to user_path(users(:technician))
  end

  test 'should get new when sufficient permissions' do
    log_in users(:manager)
    get new_user_path
    assert_response :success
  end

  test 'shouldn\'t get edit when not logged in' do
    get edit_user_url(users(:client))
    assert_redirected_to login_path
  end

  test 'shouldn\'t get edit when insufficient permissions' do
    log_in users(:client)
    get edit_user_url(users(:client))
    assert_redirected_to user_path(users(:client))
    log_in users(:technician)
    get edit_user_url(users(:client))
    assert_redirected_to user_path(users(:technician))
  end

  test 'should get edit when sufficient permissions' do
    log_in users(:manager)
    get edit_user_url(users(:client))
    assert_response :success
  end

  test 'shouldn\'t show user when not logged in' do
    get user_url(users(:manager))
    assert_redirected_to login_path
  end

  test 'shouldn\'t show user when insufficient permissions' do
    log_in users(:client)
    get user_url(users(:manager))
    assert_redirected_to user_path(users(:client))
    log_in users(:technician)
    get user_url(users(:manager))
    assert_redirected_to user_path(users(:technician))
  end

  test 'should show user when sufficient permissions' do
    log_in users(:manager)
    get user_url(users(:client))
    assert_response :success
  end

  test 'users can see own accounts' do
    log_in users(:client)
    get user_url(users(:client))
    assert_response :success
    log_in users(:technician)
    get user_url(users(:technician))
    assert_response :success
  end

  test "shouldn't create user when not logged in" do
    assert_no_difference('User.count') do
      post users_url, params: { user: { email: 'some@email.com',
                                        name: 'That guy',
                                        password: 'password',
                                        password_confirmation: 'password',
                                        permission_id: permissions(:p0).id } }
    end

    assert_redirected_to login_path
  end
  test "shouldn't create user when insufficient permissions" do
    log_in users(:client)
    assert_no_difference('User.count') do
      post users_url, params: { user: { email: 'some@email.com',
                                        name: 'That guy',
                                        password: 'password',
                                        password_confirmation: 'password',
                                        permission_id: permissions(:p0).id } }
    end

    assert_redirected_to user_path(users(:client))
    log_in users(:technician)
    assert_no_difference('User.count') do
      post users_url, params: { user: { email: 'some@email.com',
                                        name: 'That guy',
                                        password: 'password',
                                        password_confirmation: 'password',
                                        permission_id: permissions(:p0).id } }
    end

    assert_redirected_to user_path(users(:technician))
  end
  test 'should create user with sufficient permissions' do
    log_in users(:manager)
    assert_difference('User.count') do
      post users_url, params: { user: { email: 'some@email.com',
                                        name: 'That guy',
                                        password: 'password',
                                        password_confirmation: 'password',
                                        permission_id: permissions(:p0).id } }
    end
  end

  # test "should update user" do
  #   patch user_url(@user), params: { user: { email: @user.email, name: @user.name } }
  #   assert_redirected_to user_url(@user)
  # end

  # test "should destroy user" do
  #   assert_difference('User.count', -1) do
  #     delete user_url(@user)
  #   end

  #   assert_redirected_to users_url
  # end
end
