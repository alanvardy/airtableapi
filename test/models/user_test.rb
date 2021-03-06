# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'returns a site count when one site' do
    load_airtable_objects
    assert_equal '1 site', users(:linked_client).num_sites
  end
  test 'returns a site count when two sites' do
    load_airtable_objects
    @second_site = Site.all_cached.last
    @second_connection = Connection.create(site_id: @second_site.id,
                                           user_id: users(:linked_client).id)
    assert_equal '2 sites', users(:linked_client).num_sites
  end

  test 'returns all sites for technician or manager' do
    assert_equal @@sites.sort_by(&:title), users(:technician).sites
    assert_equal @@sites.sort_by(&:title), users(:manager).sites
  end

  test 'returns single site for linked client' do
    load_airtable_objects
    assert_equal @@site, users(:linked_client).sites[0]
    assert_equal 1, users(:linked_client).sites.count
  end

  test 'returns no sites for unlinked client' do
    load_airtable_objects
    assert_equal [], users(:client).sites
  end
end
