class OrderTicket < ApplicationRecord
  belongs_to :client
  belongs_to :employee
  belongs_to :pay_method
  has_many :order_ticket_items, dependent: :delete_all
  has_many :sales_invoices
  accepts_nested_attributes_for :order_ticket_items, :allow_destroy => true

  extend Enumerize

  enumerize :state, in: [:invoiced , :in_progress, :no_billing]
end
