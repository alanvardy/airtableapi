# frozen_string_literal: true

Airrecord.api_key = ENV['AIRTABLE_KEY']

class Site < Airrecord::Table
  self.base_key = ENV['BASE_KEY']
  self.table_name = 'Sites'

  has_many :equipment, class: 'Equipment', column: 'Equipment'

  def self.all_cached
    Rails.cache.fetch('all_sites') { puts 'sites not cached'; all }
  end

  def self.one_cached(id)
    Rails.cache.fetch(id) { puts 'site not cached'; Site.find(id) }
  end

  def cached_equipment
    Rails.cache.fetch("#{id}_equipment") { puts 'site equipment not cached'; equipment.reverse }
  end

  def title
    fields['Name']
  end

  def url
    "/sites/#{id}"
  end
end
