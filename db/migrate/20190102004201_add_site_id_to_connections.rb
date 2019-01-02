# frozen_string_literal: true

class AddSiteIdToConnections < ActiveRecord::Migration[5.2]
  def change
    add_column :connections, :site_id, :string
  end
end
