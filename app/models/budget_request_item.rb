class BudgetRequestItem < ApplicationRecord
  belongs_to :budget_request
  belongs_to :product
  #def get_cheapest_products
  #  budget_items = BudgetRequestItem.find_each
    #ordena el array con los budget_items en orden asc 
    #de acuerdo al precio
  #  sorted_items = budget_items.sort_by { |bi| bi.price }

  #  cheapest_products = sorted_items
    
    #devuelve una copia del arreglo filtrando los elementos con 
    #product_id repetidos
  #  return cheapest_products.uniq { |ch| ch.product_id }
  #end
  def self.get_cheapest_products
    budget_items = BudgetRequestItem.find_each
    #ordena el array con los budget_items en orden asc 
    #de acuerdo al precio
    sorted_items = budget_items.sort_by { |bi| bi.price }

    cheapest_products = sorted_items
    
    #devuelve una copia del arreglo filtrando los elementos con 
    #product_id repetidos
    return cheapest_products.uniq { |ch| ch.product_id }
  end
end