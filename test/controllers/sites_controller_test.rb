# frozen_string_literal: true

require 'test_helper'

class SitesControllerTest < ActionDispatch::IntegrationTest
  setup do
    load_airtable_objects
  end

  test "shouldn't get index when not logged in" do
    get sites_index_url
    assert_redirected_to login_path
  end

  test 'should get index when sufficient permissions' do
    log_in(users(:linked_client))
    get sites_index_url
    assert_response :success

    log_in(users(:technician))
    get sites_index_url
    assert_response :success
  end

  test "shouldn't get show when not logged in" do
    get @@site.url
    assert_redirected_to login_path
  end

  test "shouldn't get show when insufficient permissions" do
    log_in users(:client)
    get @@site.url
    assert_redirected_to user_path(users(:client))
  end

  test 'should get show with sufficient permissions' do
    log_in users(:linked_client)
    get @@site.url
    assert_response :success

    log_in users(:technician)
    get @@site.url
    assert_response :success

    log_in users(:manager)
    get @@site.url
    assert_response :success
  end
end
