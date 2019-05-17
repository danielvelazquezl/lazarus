class Client < ApplicationRecord
  belongs_to :person
  has_many :client_cash_movements, :class_name => 'CashMovement', foreign_key: 'client_id'
end
