class Artwork < ApplicationRecord
  belongs_to :artist,
    class_name: :User

  validates :title, :image_url, presence: :true
  validates :artist_id, uniqueness: {scope: :title}

  has_many :shares,
    class_name: :ArtworkShare

  has_many :shared_viewers,
    through: :shares,
    source: :viewer

  has_many :comments,
    dependent: :destroy
end