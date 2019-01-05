# frozen_string_literal: true

Airrecord.api_key = ENV['AIRTABLE_KEY']

class Equipment < Airrecord::Table
  self.base_key = ENV['BASE_KEY']
  self.table_name = 'Equipment'

  belongs_to :site, class: 'Site', column: 'Site'
end
