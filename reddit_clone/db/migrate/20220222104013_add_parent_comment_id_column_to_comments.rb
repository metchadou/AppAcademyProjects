class AddParentCommentIdColumnToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :parent_comment_id, :integer
  end
end
