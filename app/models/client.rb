class Client < ApplicationRecord
  belongs_to :person, :dependent => :delete
  has_many :client_cash_movements, :class_name => 'CashMovement', foreign_key: 'client_id'
end
