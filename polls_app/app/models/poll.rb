class Poll < ApplicationRecord
  validates :title, presence: true

  belongs_to :author,
    class_name: :User

  has_many :questions
end