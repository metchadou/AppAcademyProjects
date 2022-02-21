class Track < ApplicationRecord
  validates :title, :ord, presence: true

#   If you want to validate the presence of a boolean field (where the real values are true and false), you will want to use validates_inclusion_of :field_name, in: [true, false].
# This is due to the way Object#blank? handles boolean values: false.blank? # => true.
  validates :bonus, inclusion: {in: [true, false]}

  belongs_to :album

  has_many :notes

  def category=(category)
    category == 'bonus' ? self.bonus = true : self.bonus = false
  end
end
