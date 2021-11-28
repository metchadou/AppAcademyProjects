class CreateTaggings < ActiveRecord::Migration[5.2]
  def change
    create_table :taggings do |t|
      t.integer :tag_topic_id, null: false
      t.integer :short_url_id, null: false

      t.index :tag_topic_id
      t.index :short_url_id
      t.timestamps
    end
  end
end
