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

    # validate :update_stock

    after_update :update_stock

    private

    def update_stock
        if self.date_finished.nil?
            if is_component?
                begin
                    Order.transaction do

                        order_items.each do |oi|
                            quantity = oi.quantity
                            product_id = oi.product_id

                            @stock_origin = Stock.where(deposit_id: self.origin, product_id: product_id).first
                            @stock_origin.reduce_stock!(product_id, quantity)

                            @stock_destination = Stock.where(deposit_id: self.destination, product_id: product_id).first
                            @stock_destination.increase_stock!(quantity)

                        end
                    end

                rescue StandardError => e
                    puts e.message
                    self.errors.add(:quantity, "Cantidad insuficiente para realizar esta transaccion")
                    raise ActiveRecord::RecordInvalid.new(self)
                end

                #  si es una orden de produccion, disminuyo la cantidad de componentes en
                # el stock de produccion y aumento la cantidad de productos en el stock de
                # productos
            elsif is_product?
                begin
                    Order.transaction do
                        order_items.each do |oi|
                            quantity = oi.quantity
                            product_id = oi.product_id

                            @product = Product.where(id: product_id).first
                            @product.product_items.each do |pi|
                                component_id = pi.component_id
                                component_quantity = pi.quantity

                                @stock_c_origin = Stock.where(deposit_id: self.origin, product_id: component_id).first
                                @stock_c_origin.reduce_stock!(product_id, component_quantity * quantity)
                            end
                            @stock_p_destination = Stock.where(deposit_id: self.destination, product_id: product_id).first
                            @stock_p_destination.reduce_stock!(product_id, quantity)
                        end
                    end
                rescue StandardError => e
                    puts e.message
                    self.errors.add(:quantity, "Cantidad insuficiente para realizar esta transaccion")
                    raise ActiveRecord::RecordInvalid.new(self)
                end
            end
        end
    end



    def is_product?
        self.order_type.production?
    end

    def is_component?
        self.order_type.component?
    end

    def finished?
        self.state == 'finished'
    end


end
