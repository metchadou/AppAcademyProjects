class Album < ApplicationRecord
  validates :title, :year, presence: true

#   If you want to validate the presence of a boolean field (where the real values are true and false), you will want to use validates_inclusion_of :field_name, in: [true, false].
# This is due to the way Object#blank? handles boolean values: false.blank? # => true.
  validates :studio, inclusion: { in: [true, false]}

  belongs_to :band

  has_many :tracks,
    dependent: :destroy

  def is_studio?
    self.studio
  end

  def category=(category)
    category == 'live' ? self.studio = false : self.studio = true
  end
end