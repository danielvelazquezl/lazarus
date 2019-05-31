class Person < ApplicationRecord
  acts_as_paranoid

  has_many :orders
  has_many :forms
  has_many :movement_proofs

  resourcify
end
