class RenameUserId < ActiveRecord::Migration[5.2]
  def change
    rename_column :comments, :user_id, :author_id
  end
end
