class Product < ApplicationRecord
  acts_as_paranoid

  has_many :product_items, dependent: :delete_all
  has_many :stocks
  has_one :brand
  has_one :product_category
  has_one_attached :image

  accepts_nested_attributes_for :product_items, :allow_destroy => true

  validates :brand_id, :presence => { message: "Marca no valida"}
  validates :product_category_id, :presence => { message: "Categoria no valida"}

  extend Enumerize

  enumerize :product_type, in: [:component,:product,:both]

  scope :products_all, ->{where(product_type: :product)}
  scope :components_all, ->{where(product_type: :component)}
  scope :products_from_d1, -> { joins(:stocks).merge(Stock.stock_from_d1) }

  resourcify
  end


