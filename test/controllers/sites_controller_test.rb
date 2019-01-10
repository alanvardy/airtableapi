# frozen_string_literal: true

require 'test_helper'

class SitesControllerTest < ActionDispatch::IntegrationTest
  setup do
    fill_db
  end

  test "shouldn't get index when not logged in" do
    get sites_index_url
    assert_redirected_to login_path
  end

  test 'should get index when sufficient permissions' do
    log_in(users(:client))
    get sites_index_url
    assert_response :success

    log_in(users(:technician))
    get sites_index_url
    assert_response :success
  end

  test "shouldn't get show when not logged in" do
    get "/sites/#{@site.id}"
    assert_redirected_to login_path
  end

  test "shouldn't get show when insufficient permissions" do
    log_in users(:client)
    get "/sites/#{@site.id}"
    assert_redirected_to user_path(users(:client))
  end

  test 'should get show with sufficient permissions' do
    log_in users(:client)
    get "/sites/#{@connected_site.id}"
    assert_response :success

    log_in users(:technician)
    get "/sites/#{@site.id}"
    assert_response :success

    log_in users(:manager)
    get "/sites/#{@site.id}"
    assert_response :success
  end
end
