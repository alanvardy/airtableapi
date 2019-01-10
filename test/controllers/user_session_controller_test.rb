# frozen_string_literal: true

require 'test_helper'

class UserSessionControllerTest < ActionDispatch::IntegrationTest
  setup do
    fill_db
  end

  test 'should get new' do
    get login_path
    assert_response :success
  end

  test 'should get create' do
    post login_path, params: {  email: users(:client).email,
                                password: 'password' }
    assert_redirected_to user_path(users(:client))
  end

  test 'should get destroy' do
    get logout_path
    assert_redirected_to root_path
    assert_equal('You have logged out', flash[:success])
  end
end
