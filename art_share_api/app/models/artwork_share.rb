class ArtworkShare < ApplicationRecord
  belongs_to :artwork
  belongs_to :viewer,
    class_name: :User

  validates :artwork, :viewer, presence: true
  validates :viewer_id, uniqueness: {scope: :artwork_id}
end