class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.text :body
      t.integer :chat_id
      t.integer :user_id
      t.timestamps
    end
    add_index :messages, :chat_id
    add_index :messages, :user_id
  end
end
