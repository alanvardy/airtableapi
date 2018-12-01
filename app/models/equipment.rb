Airrecord.api_key = ENV["AIRTABLE_KEY"]

class Equipment < Airrecord::Table
  self.base_key = "appGudUs9Mc0X6Ldo"
  self.table_name = "Equipment"

  belongs_to :site, class: "Site", column: "Site"
end
