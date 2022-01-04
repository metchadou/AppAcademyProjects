class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true

  has_many :artworks,
    foreign_key: :artist_id,
    dependent: :destroy

  has_many :artwork_share_views,
    foreign_key: :viewer_id,
    class_name: :ArtworkShare,
    dependent: :destroy

  has_many :shared_artworks,
    through: :artwork_share_views,
    source: :artwork

  has_many :comments,
    foreign_key: :author_id,
    dependent: :destroy

end