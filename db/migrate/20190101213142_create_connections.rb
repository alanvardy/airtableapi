# frozen_string_literal: true

class CreateConnections < ActiveRecord::Migration[5.2]
  def change
    create_table :connections do |t|
      t.belongs_to :site, foreign_key: true
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
