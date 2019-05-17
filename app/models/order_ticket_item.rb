class OrderTicketItem < ApplicationRecord
  belongs_to :order_ticket
  belongs_to :product
end
