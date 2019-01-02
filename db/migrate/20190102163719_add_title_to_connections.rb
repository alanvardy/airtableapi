class AddTitleToConnections < ActiveRecord::Migration[5.2]
  def change
    add_column :connections, :title, :string
  end
end
