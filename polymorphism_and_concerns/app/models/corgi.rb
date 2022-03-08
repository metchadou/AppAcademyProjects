class Corgi < ApplicationRecord
  include Toyable

  validates :name, presence: true
end
