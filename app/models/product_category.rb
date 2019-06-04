class ProductCategory < ApplicationRecord
has_many :products, dependent: :nullify
    
    def self.options_for_select
        categories = ProductCategory.arel_table
        # order('LOWER(name)').map { |e| [e.name, e.id] }
        order(categories[:description].lower).pluck(:description, :id)
    end
end
