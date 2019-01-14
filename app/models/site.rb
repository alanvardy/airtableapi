# frozen_string_literal: true

Airrecord.api_key = ENV['AIRTABLE_KEY']

class Site < Airrecord::Table
  self.base_key = ENV['BASE_KEY']
  self.table_name = 'Sites'

  has_many :equipment, class: 'Equipment', column: 'Equipment'

  def self.all_cached
    Rails.cache.fetch('all_sites', expires_in: rand(15..30).minutes, race_condition_ttl: 30.seconds) { puts 'sites not cached'; all.sort_by(&:title) }
  end

  def self.one_cached(id)
    Rails.cache.fetch("site_#{id}", expires_in: rand(15..30).minutes, race_condition_ttl: 30.seconds) { puts 'site not cached'; Site.find(id) }
  end

  def self.search(query, allowed_sites)
    return nil if query.nil?

    sites = Rails.cache.fetch('all_sites', expires_in: rand(15..30).minutes, race_condition_ttl: 30.seconds) { puts 'sites not cached'; all.sort_by(&:title) }
    selected_sites = sites.select { |site| site.title.downcase.include? query.downcase }
    selected_sites.select { |site| allowed_sites.map(&:id).include? site.id }
  end

  # All equipment belonging to site with caching
  def cached_equipment
    Rails.cache.fetch("#{id}_equipment", expires_in: rand(5..15).minutes, race_condition_ttl: 30.seconds) { puts 'site equipment not cached'; equipment.sort_by(&:number) }
  end

  def num_equipment
    fields['Equipment'].count
  end

  def title
    fields['Name']
  end

  def url
    "/sites/#{id}"
  end
end
