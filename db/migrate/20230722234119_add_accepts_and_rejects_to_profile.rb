class AddAcceptsAndRejectsToProfile < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :accepts, :integer, array: true, default: []
    add_column :profiles, :rejects, :integer, array: true, default: []
  end
end
