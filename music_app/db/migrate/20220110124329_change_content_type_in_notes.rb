class ChangeContentTypeInNotes < ActiveRecord::Migration[5.2]
  def change
    change_column :notes, :content, :text, null: false
  end
end
