class Sub < ApplicationRecord
  validates :title, presence: {message: "is required"}
  validates :description, presence: {message: "is required"}

  belongs_to :moderator,
    class_name: :User

  has_many :post_subs,
    dependent: :destroy,
    inverse_of: :sub

  has_many :posts,
    through: :post_subs,
    source: :post

end
