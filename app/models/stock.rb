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
    if self.deposit_id == 1
      PurchaseRequest.modify_purchase_request(product_id, self.quantity, self.min_stock, quantity)
    end
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

  filterrific :default_filter_params => {:sorted_by => 'product_asc'},
              :available_filters => %w[
                  sorted_by
                  search_query
                  with_deposit_id
                ]

  # default for will_paginate
  self.per_page = 10

  scope :search_query, lambda { |query|
    return nil  if query.blank?
    # condition query, parse into individual keywords
    terms = query.downcase.split(/\s+/)
    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map { |e|
      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conditions = 1
    where(
        terms.map {
          or_clauses = [
              "LOWER(products.description) LIKE ?"
          ].join(' OR ')
          "(#{ or_clauses })"
        }.join(' AND '),
        *terms.map { |e| [e] * num_or_conditions }.flatten
    ).joins(:product).references(:products)
  }

  scope :sorted_by, ->(sort_option) {
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    stocks = Stock.arel_table
    deposits = Deposit.arel_table
    products = Product.arel_table
    case sort_option.to_s
    when /^internal_code_/
      order(stocks[:internal_code].send(direction))
    when /^deposit_/
      Stock.joins(:deposit).order(deposits[:description].lower.send(direction)).order(stocks[:internal_code].send(direction))
    when /^product_/
      Stock.joins(:product).order(products[:description].lower.send(direction)).order(stocks[:internal_code].send(direction))
    else
      raise(ArgumentError, "Invalid sort option: #{sort_option.inspect}")
    end
  }

  scope :with_deposit_id, ->(deposit_ids) {
    where(:deposit_id => [*deposit_ids])
  }

  scope :with_product_id, ->(product_ids) {
    where(:product_id => [*product_ids])
  }

  delegate :description, :to => :deposit, :prefix => true
  delegate :description, :to => :product, :prefix => true

  def self.options_for_sorted_by
    [
        ['Deposito (a-z)', 'deposit_asc'],
        ['Deposito (z-a)', 'deposit_desc'],
        ['Producto (a-z)', 'product_asc'],
        ['Producto (z-a)', 'product_desc']
    ]
  end
end
