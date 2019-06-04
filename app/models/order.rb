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


    filterrific :default_filter_params => {:sorted_by => 'created_at_asc'},
                :available_filters => %w[
                  sorted_by
                  search_query
                  with_created_at_gte
                  with_person_id
                ]

    # default for will_paginate
    self.per_page = 10

    scope :search_query, ->(query) {
        return nil if query.blank?
        # condition query, parse into individual keywords
        terms = query.downcase.split(/\s+/)
        # replace "*" with "%" for wildcard searches,
        # append '%', remove duplicate '%'s
        terms = terms.map {|e|
            (e.gsub('*', '%') + '%').gsub(/%+/, '%')
        }
        # configure number of OR conditions for provision
        # of interpolation arguments. Adjust this if you
        # change the number of OR conditions.
        num_or_conditions = 1
        where(
            terms.map {
                or_clauses = [
                    "LOWER(people.name) LIKE ?"
                ].join(' OR ')
                "(#{ or_clauses })"
            }.join(' AND '),
            *terms.map {|e| [e] * num_or_conditions}.flatten
        ).joins(:person).references(:people)
    }

    scope :sorted_by, ->(sort_option) {
        # extract the sort direction from the param value.
        direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
        orders = Order.arel_table
        persons = Person.arel_table
        case sort_option.to_s
        when /^created_at_/
            order(orders[:date_request].send(direction))
        when /^finish_at_/
            order(orders[:date_finished].send(direction))
        when /^person_/
            Order.joins(:person).order(persons[:name].lower.send(direction)).order(orders[:date_request].send(direction))
        when /^state_/
            order(orders[:state]).send(direction)
        else
            raise(ArgumentError, "Invalid sort option: #{sort_option.inspect}")
        end
    }

    scope :with_deposit_id, ->(deposit_ids) {
        where(:deposit_id => [*deposit_ids])
    }

    scope :with_person_id, ->(person_ids) {
        where(:person_id => [*person_ids])
    }

    scope :with_created_at_gte, ->(ref_date) {
        where('orders.date_request >= ?', ref_date)
    }

    scope :with_state, ->(ref_date) {
        where('orders.date_requested >= ?', ref_date)
    }

    delegate :name, :to => :person, :prefix => true

    def self.options_for_sorted_by
        [
            ['Fecha Pedido (Viejos primero)', 'created_at_asc'],
            ['Fecha Pedido (Recientes primero)', 'created_at_desc'],
            ['Fecha Finalizado (Viejos primero)', 'finished_at_asc'],
            ['Fecha Finalizado (Recientes primero)', 'finished_at_desc'],
            ['Encargado (a-z)', 'person_asc'],
            ['Encargado (z-a)', 'person_desc']
        ]
    end

end
