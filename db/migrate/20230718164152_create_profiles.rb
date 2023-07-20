# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :location
      t.date :dob
      t.float :lat
      t.float :long
      t.integer :seeking
      t.integer :adventures, array: true, default: []
      t.timestamps
    end
    add_index :profiles, :user_id
  end
end
