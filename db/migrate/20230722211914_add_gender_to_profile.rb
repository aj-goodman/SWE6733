class AddGenderToProfile < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :looking_for, :integer
    add_column :profiles, :gender, :string
    change_column :profiles, :seeking, :string
  end
end
