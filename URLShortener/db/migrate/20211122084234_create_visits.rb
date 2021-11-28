class CreateVisits < ActiveRecord::Migration[5.2]
  def change
    create_table :visits do |t|
      t.integer :user_id, null: false
      t.integer :short_url_id, null: false
      t.index :user_id
      t.index :short_url_id

      t.timestamps
    end
  end
end
