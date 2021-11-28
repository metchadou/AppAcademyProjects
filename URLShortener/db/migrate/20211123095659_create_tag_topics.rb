class CreateTagTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :tag_topics do |t|
      t.string :title, null: false

      t.index :title, unique: true
    end
  end
end
