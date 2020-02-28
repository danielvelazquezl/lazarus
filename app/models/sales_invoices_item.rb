class SalesInvoicesItem < ApplicationRecord
  belongs_to :sales_invoice
  belongs_to :product
end
