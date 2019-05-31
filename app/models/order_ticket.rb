class OrderTicket < ApplicationRecord
  belongs_to :client
  belongs_to :employee
  has_many :order_ticket_items, dependent: :delete_all
  has_many :sales_invoices
  accepts_nested_attributes_for :order_ticket_items, :allow_destroy => true

  extend Enumerize

  enumerize :state, in: [:invoiced, :uninvoiced]
end
