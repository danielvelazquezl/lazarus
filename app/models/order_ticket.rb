class OrderTicket < ApplicationRecord
  belongs_to :client
  belongs_to :employee
  belongs_to :pay_method
  has_many :sales_invoices
end
