# frozen_string_literal: true

Airrecord.api_key = ENV['AIRTABLE_KEY']

class Site < Airrecord::Table
  self.base_key = ENV['BASE_KEY']
  self.table_name = 'Sites'

  has_many :equipment, class: 'Equipment', column: 'Equipment'

  def self.all_cached
    Rails.cache.fetch('all_sites', expires_in: 1.minute, race_condition_ttl: 30.seconds ) { puts 'sites not cached'; all.sort_by(&:title) }
  end

  def self.one_cached(id)
    Rails.cache.fetch("site_#{id}", expires_in: 1.minute, race_condition_ttl: 30.seconds ) { puts 'site not cached'; Site.find(id) }
  end

  # All equipment belonging to site with caching
  def cached_equipment
    Rails.cache.fetch("#{id}_equipment", expires_in: 1.minute, race_condition_ttl: 30.seconds ) { puts 'site equipment not cached'; equipment.sort_by(&:number) }
  end

  def num_equipment
    cached_equipment.count
  end

  def title
    fields['Name']
  end

  def url
    "/sites/#{id}"
  end
end
