class AddPresenceConstraintToUserId < ActiveRecord::Migration[5.2]
  def change
    change_column :cats, :user_id, :integer, null: false
  end
end
