class CreatePolls < ActiveRecord::Migration[5.2]
  def change
    create_table :polls do |t|
      t.text :title, null: false
      t.integer :author_id, null: false

      t.timestamps
    end
    add_index :polls, :author_id
  end
end
