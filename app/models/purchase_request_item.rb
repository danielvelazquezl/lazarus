class PurchaseRequestItem < ApplicationRecord
  belongs_to :purchase_request
  belongs_to :product


end
