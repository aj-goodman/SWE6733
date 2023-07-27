class CreateChats < ActiveRecord::Migration[7.0]
  def change
    create_table :chats do |t|
      t.integer :user_ids, array: true
      t.timestamps
    end
  end
end
