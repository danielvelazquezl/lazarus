class Order < ApplicationRecord
    belongs_to :person
    belongs_to :origin, :class_name => 'Deposit'
    belongs_to :destination, :class_name => 'Deposit'
    has_many :order_items, dependent: :delete_all
    accepts_nested_attributes_for :order_items, :allow_destroy => true

    extend Enumerize

    enumerize :order_type, in: [:production , :component]
    enumerize :state, in: [:draft , :created, :in_progress, :finished, :canceled]

    scope :components_order, ->{where(order_type: :component)}
    scope :products_order, ->{where(order_type: :production)}

    after_update :update_stock

    private
    def update_stock
        if self.state == 'finished' && self.date_finished == nil
            if self.order_type.component?
                order_items.each do |oi|
                    quantity = oi.quantity
                    product_id = oi.product_id

                    Stock.reduce_stock(product_id, self.origin, quantity)
                    Stock.increase_stock(product_id, self.destination, quantity)
                end

                #  si es una orden de produccion, disminuyo la cantidad de componentes en
                # el stock de produccion y aumento la cantidad de productos en el stock de
                # productos
            elsif self.order_type.production?
                order_items.each do |oi|
                    quantity = oi.quantity
                    product_id = oi.product_id

                    product = Product.where("id = ?", product_id).first

                    product.product_items.each do |pi|
                        component_id = pi.component_id
                        component_quantity = pi.quantity

                        Stock.reduce_stock(component_id, self.origin, component_quantity*quantity)
                    end
                    Stock.increase_stock(product_id, self.destination, quantity)
                end

            end
        end

    end
  end
