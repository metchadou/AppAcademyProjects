class AddNotNullContraintToUsersAndShortenedUrlsTables < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :email, :string, null: false
    change_column :shortened_urls, :short_url, :string, null: false
    change_column :shortened_urls, :long_url, :string, null: false
    change_column :shortened_urls, :user_id, :integer, null: false
  end
end
