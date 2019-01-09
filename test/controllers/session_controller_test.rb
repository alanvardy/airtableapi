# frozen_string_literal: true

require 'test_helper'

class SessionControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get session_new_url
    assert_response :success
  end

  test 'should log in admin with correct username and password' do
    post session_create_url, params: { admin: { username: ENV['ADMIN_USERNAME'],
                                                password: ENV['ADMIN_PASS'] } }
    assert_redirected_to root_path
    assert_equal(flash[:success], 'You have logged in')
  end

  test 'should not log in admin with wrong password' do
    post session_create_url, params: { admin: { username: ENV['ADMIN_USERNAME'],
                                                password: 'blah' } }
    assert_redirected_to session_new_url
    assert_equal(flash[:danger], 'Sorry, wrong credentials')
  end

  test 'should not log in admin with wrong username' do
    post session_create_url, params: { admin: { username: 'yuppers',
                                                password: ENV['ADMIN_PASS'] } }
    assert_redirected_to session_new_url
    assert_equal(flash[:danger], 'Sorry, wrong credentials')
  end

  test 'should get destroy' do
    get session_destroy_url
    assert_redirected_to root_path
    assert_equal(flash[:success], 'You have logged out')
  end
end
