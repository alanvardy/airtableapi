class AddPermissionIdToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :permission_id, :integer
  end
end
