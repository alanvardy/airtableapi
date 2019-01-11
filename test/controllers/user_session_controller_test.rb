# frozen_string_literal: true

require 'test_helper'

class UserSessionControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get login_path
    assert_response :success
  end

  test 'should log in' do
    post login_path, params: {  email: users(:client).email,
                                password: 'password' }
    assert_redirected_to user_path(users(:client))
    assert_equal 'You have logged in', flash[:success]
  end

  test 'shouldn\'t log in when bad password' do
    post login_path, params: {  email: users(:client).email,
                                password: 'notpassword' }
    assert_redirected_to login_path
    assert_equal 'Sorry, wrong credentials', flash[:danger]
  end

  test 'should get destroy' do
    get logout_path
    assert_redirected_to root_path
    assert_equal('You have logged out', flash[:success])
  end
end
