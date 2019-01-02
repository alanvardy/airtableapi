# frozen_string_literal: true

class RemoveSiteFromConnections < ActiveRecord::Migration[5.2]
  def change
    remove_column :connections, :site_id
  end
end
