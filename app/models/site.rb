# frozen_string_literal: true

Airrecord.api_key = ENV['AIRTABLE_KEY']

class Site < Airrecord::Table
  self.base_key = ENV['BASE_KEY']
  self.table_name = 'Sites'

  has_many :equipment, class: 'Equipment', column: 'Equipment'

  def title
    fields['Name']
  end

  def url
    "/sites/#{id}"
  end
end
