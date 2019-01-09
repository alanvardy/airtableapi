# frozen_string_literal: true

require 'test_helper'

class EquipmentControllerTest < ActionDispatch::IntegrationTest
  setup do
    fill_db
  end

  test 'can\'t get index when not logged in' do
    get equipment_index_path
    assert_redirected_to login_path
  end

  test 'can\'t get index when insufficient permissions' do
    log_in @client
    get equipment_index_path
    assert_redirected_to user_path(@client)

    log_in @technician
    get equipment_index_path
    assert_redirected_to user_path(@technician)
  end

  test 'can get index when sufficient permissions' do
    log_in @manager
    get equipment_index_path
    assert_response :success
  end

  test 'can\'t get site when not logged in' do
    get "/sites/#{@site.id}"
    assert_redirected_to login_path
  end

  test 'can\'t get site when insufficient permissions' do
    log_in @client
    get "/sites/#{@site.id}"
    assert_redirected_to user_path(@client)
  end

  test 'can get site when sufficient permissions' do
    log_in @client
    get "/sites/#{@connected_site.id}"
    assert_response :success

    log_in @technician
    get "/sites/#{@site.id}"
    assert_response :success

    log_in @manager
    get "/sites/#{@site.id}"
    assert_response :success
  end
end
