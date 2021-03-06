# frozen_string_literal: true

Airrecord.api_key = ENV['AIRTABLE_KEY']

class Equipment < Airrecord::Table
  self.base_key = ENV['BASE_KEY']
  self.table_name = 'Equipment'

  ### Associations ###
  belongs_to :site, class: 'Site', column: 'Site'

  def self.all_cached
    Rails.cache.fetch('all_equipment', expires_in: rand(5..15).minutes, race_condition_ttl: 30.seconds) { puts 'all equipment not cached'; all.reverse }
  end

  def self.one_cached(id)
    Rails.cache.fetch("#{id}_equipment", expires_in: rand(5..15).minutes, race_condition_ttl: 30.seconds) { puts 'equipment not cached'; Equipment.find(id) }
  end

  def attachments
    fields['Attachments']
  end

  def attachments?
    !attachments.nil?
  end

  def num_attachments
    fields['Attachments'].count
  end

  ### Attributes ###
  def url
    "/equipment/#{id}"
  end

  def model
    fields['Model']
  end

  def serial
    fields['Serial']
  end

  def make
    fields['Make']
  end

  def type
    fields['Type']
  end

  def number
    fields['#']
  end
end
