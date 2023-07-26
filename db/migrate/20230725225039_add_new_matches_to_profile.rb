class AddNewMatchesToProfile < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :new_matches, :boolean, default: false
  end
end
