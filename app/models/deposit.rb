class Deposit < ApplicationRecord
  has_many :stocks
  has_many :origin_orders, :class_name => 'Order', :foreign_key => 'origin_id'
  has_many :destination_orders, :class_name => 'Order', :foreign_key => 'destination_id'
  has_many :origin_forms, :class_name => 'Form', :foreign_key => 'origin_id'
  has_many :destination_forms, :class_name => 'Form', :foreign_key => 'destination_id'
  has_many :movement_proof

  scope :deposit_1, -> { where(description: "Deposito 1") }

  def self.options_for_select
    deposits = Deposit.arel_table
    # order('LOWER(name)').map { |e| [e.name, e.id] }
    order(deposits[:description].lower).pluck(:description, :id)
  end
  resourcify
end
