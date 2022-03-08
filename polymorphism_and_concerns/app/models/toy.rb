class Toy < ApplicationRecord
  validates :name, presence: true, uniqueness: {scope: [:toyable]}
  belongs_to :toyable, polymorphic: true
end
