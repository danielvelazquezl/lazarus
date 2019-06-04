class Person < ApplicationRecord
  acts_as_paranoid

  has_many :orders
  has_many :forms
  has_many :movement_proofs

  has_one :client
  has_one :employee
  has_one :provider

  resourcify

  def self.options_for_select
    persons = Person.arel_table
    # order('LOWER(name)').map { |e| [e.name, e.id] }
    order(persons[:name].lower).pluck(:name, :id)
  end


end
