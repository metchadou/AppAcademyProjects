class Vote < ApplicationRecord
  validates :value, presence: true, inclusion: [1, -1]

  belongs_to :votable,
    :polymorphic => true
end
