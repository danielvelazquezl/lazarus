class Stock < ApplicationRecord
  belongs_to :product
  belongs_to :deposit

  validates :quantity, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :min_stock, numericality: {only_integer: true, greater_than_or_equal_to: 0}

  validate :check_min_stock, on: [:create, :update]

  scope :stock_from_d1, -> { joins(:deposit).merge(Deposit.deposit_1) }

  def check_min_stock
    if self.quantity < self.min_stock
      errors.add(:quantity, "no puede ser menor a la cantidad minima")
    end
  end

  def self.reduce_stock(product_id, deposit_id, quantity)
    stock = Stock.where("deposit_id = ? and product_id = ?", deposit_id, product_id).first
    stock.update_attributes(quantity: stock.quantity - quantity)
  end


  def self.increase_stock(product_id, deposit_id, quantity)
    stock = Stock.where("deposit_id = ? and product_id = ?", deposit_id, product_id).first
    stock.update_attributes(quantity: stock.quantity + quantity)
  end

  def self.modify_stock(product_id, deposit_id, quantity, flag)
    if flag == '-'
      reduce_stock(product_id,deposit_id,quantity)

    elsif flag == '+'
      increase_stock(product_id, deposit_id, quantity)

    end
  end

  def self.search(search)
    where("deposit_id::text LIKE ?", "%#{search}")
  end

  def self.search(search)
    where("product_id::text LIKE ?", "%#{search}")
  end

  def product
    Product.unscoped { super }
  end

end
