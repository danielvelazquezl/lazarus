class PurchaseInvoiceItem < ApplicationRecord
  belongs_to :purchase_invoice
  belongs_to :product
end
