# frozen_string_literal: true

Airrecord.api_key = ENV['AIRTABLE_KEY']

class Site < Airrecord::Table
  self.base_key = ENV['BASE_KEY']
  self.table_name = 'Sites'

  ### Associations ###
  has_many :equipment, class: 'Equipment', column: 'Equipment'

  def self.all_cached
    Rails.cache.fetch('all_sites',
                      expires_in: rand(15..30).minutes,
                      race_condition_ttl: 30.seconds) do
      puts 'sites not cached'
      all.sort_by(&:title)
    end
  end

  def self.one_cached(id)
    Rails.cache.fetch("site_#{id}",
                      expires_in: rand(15..30).minutes,
                      race_condition_ttl: 30.seconds) do
      puts 'site not cached'
      Site.find(id)
    end
  end

  def self.search(query, allowed_sites)
    return nil if query.nil?

    selected_sites = all_cached.select do |site|
      (site.title + ' ' + site.address).downcase.include? query.downcase
    end
    selected_sites.select { |site| allowed_sites.map(&:id).include? site.id }
  end

  # All equipment belonging to site with caching
  def cached_equipment
    Rails.cache.fetch("#{id}_equipment",
                      expires_in: rand(5..15).minutes,
                      race_condition_ttl: 30.seconds) do
      puts 'site equipment not cached'
      equipment.sort_by(&:number)
    end
  end

  def num_equipment
    fields['Equipment'].count
  end

  def num_connections
    connections.count
  end

  def connections
    Connection.where(site_id: id)
  end

  def users
    user_ids = connections.map(&:user_id)
    User.find(user_ids)
  end

  ### Attributes ###

  def title
    fields['Name']
  end

  def number
    fields['SiteNumber']
  end

  def url
    "/sites/#{id}"
  end

  def address
    "#{fields['SiteAddress']}, #{fields['SiteCity']} #{fields['Postal Code']} "
  end
end
