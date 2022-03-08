class Cat < ApplicationRecord
  include Toyable

  validates :name, presence: true
end
