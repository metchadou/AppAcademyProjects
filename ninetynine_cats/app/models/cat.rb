require 'action_view'

class Cat < ApplicationRecord
  include ActionView::Helpers::DateHelper

  CAT_COLORS = %w(black brown white).freeze

  validates :birth_date, :color, :name, :sex, :description, presence: :true
  validates :sex, inclusion: { in: %w(M F) }
  validates :color, inclusion: CAT_COLORS

  has_many :rental_requests,
    class_name: :CatRentalRequest,
    dependent: :destroy

  def age
    time_ago_in_words(birth_date)
  end
end