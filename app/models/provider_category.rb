class ProviderCategory < ApplicationRecord
  belongs_to :provider
  belongs_to :product_category
end
