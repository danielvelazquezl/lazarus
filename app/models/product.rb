class Product < ApplicationRecord
  acts_as_paranoid

  has_many :product_items, dependent: :delete_all
  has_many :stocks
  belongs_to :brand
  belongs_to :product_category
  has_many :sales_invoices_item
  has_many :purchase_invoice_items
  has_one_attached :image

  accepts_nested_attributes_for :product_items, :allow_destroy => true

  validates :brand_id, :presence => {message: "Marca no valida"}
  validates :product_category_id, :presence => {message: "Categoria no valida"}

  extend Enumerize

  enumerize :product_type, in: [:component, :product, :both]

  scope :products_all, -> {where("product_type = ? OR product_type = ?", :product, :both)}
  scope :components_all, -> {where("product_type = ? OR product_type = ?", :component, :both)}
  scope :products_from_d1, -> {joins(:stocks).merge(Stock.stock_from_d1)}
  #productos con stock minimo
  scope :products_min_stock, -> { joins(:stocks).where('quantity <= min_stock') }
  #productos vendidos
  scope :sold_products, -> { joins(:sales_invoices_item) }
  #productos comprados
  scope :purchased_products, -> { joins(:purchase_invoice_items) }

  resourcify

  filterrific :default_filter_params => {:sorted_by => 'description_asc'},
              :available_filters => %w[
                  sorted_by
                  search_query
                  with_brand_id
                  with_product_category_id
                ]

  # default for will_paginate
  self.per_page = 10

  scope :search_query, lambda { |query|
    return nil if query.blank?
    # condition query, parse into individual keywords
    terms = query.to_s.downcase.split(/\s+/)
    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map { |e| ('%'+e.gsub('*','%')+'%').gsub(/%+/, '%') }
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conditions = 4
    where(
        terms.map {
          or_clauses = [
              "LOWER(products.description) LIKE ?",
              "LOWER(products.location) LIKE ?",
              "LOWER(brands.description) LIKE ?",
              "LOWER(product_categories.description) LIKE ?"
          ].join(' OR ')
          "(#{ or_clauses })"
        }.join(' AND '),
        *terms.map {|e| [e] * num_or_conditions}.flatten
    ).joins(:product_category, :brand).references(:product_categories, :brands)
  }

  scope :sorted_by, ->(sort_option) {
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    products = Product.arel_table
    brands = Brand.arel_table
    categories = ProductCategory.arel_table
    case sort_option.to_s
    when /^description_/
      order(products[:description].send(direction))
    when /^brand_/
      Product.joins(:brand).order(brands[:description].lower.send(direction)).order(products[:description].lower.send(direction))
    when /^product_category_/
      Product.joins(:product_category).order(categories[:description].lower.send(direction)).order(products[:description].lower.send(direction))
    else
      raise(ArgumentError, "Invalid sort option: #{sort_option.inspect}")
    end
  }

  scope :with_brand_id, ->(brand_ids) {
    where(:brand_id => [*brand_ids])
  }

  scope :with_product_category_id, ->(product_category_ids) {
    where(:product_category_id => [*product_category_ids])
  }

  delegate :description, :to => :brand, :prefix => true
  delegate :description, :to => :product_category, :prefix => true

  def self.options_for_sorted_by
    [
        ['Nombre (ascendente)', 'description_asc'],
        ['Nombre (descendente)', 'description_desc'],
        ['Marca (ascendente)', 'brand_asc'],
        ['Marca (descendente)', 'brand_desc'],
        ['Categoria (ascendente)', 'product_category_asc'],
        ['Categoria (descendente)', 'product_category_desc']        
    ]
  end

end


