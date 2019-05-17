class MovementType < ApplicationRecord
  acts_as_paranoid

  has_many :movement_proof
end
