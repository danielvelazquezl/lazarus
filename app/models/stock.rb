class Stock < ApplicationRecord
  belongs_to :product
  belongs_to :deposit

  validates :quantity, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :min_stock, numericality: {only_integer: true, greater_than_or_equal_to: 0}

  validate :check_quantity, on: [:create, :update]

  scope :stock_from_d1, -> { joins(:deposit).merge(Deposit.deposit_1) }


  def check_quantity
    if self.quantity <= 0
      errors.add(:quantity, "no puede ser menor a la cantidad minima")
    end
  end

  def reduce_stock!(product_id, quantity)
    # stock = Stock.where("deposit_id = ? and product_id = ?", deposit_id, product_id).first
    PurchaseRequest.modify_purchase_request(product_id, self.quantity, self.min_stock, quantity)
    update_attributes!(quantity: self.quantity - quantity)
  end


  def increase_stock!(quantity)
    update_attributes!(quantity: self.quantity + quantity)
  end

  def self.search(search)
    where("product_id::text LIKE ?", "%#{search}")
  end

  def create_purchase_request()

  end

  def product
    Product.unscoped { super }
  end

end
