class Person < ApplicationRecord
  acts_as_paranoid

  has_many :orders
  has_many :forms
  has_many :movement_proofs
  has_one :client
  has_one :provider
  has_one :employee

  #accepts_nested_attributes_for :client, allow_destroy: true

  resourcify
end
