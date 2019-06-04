class Brand < ApplicationRecord
  has_many :products, dependent: :nullify

  def self.options_for_select
    brands = Brand.arel_table
    # order('LOWER(name)').map { |e| [e.name, e.id] }
    order(brands[:description].lower).pluck(:description, :id)
  end
end
