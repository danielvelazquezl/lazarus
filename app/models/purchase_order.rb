class PurchaseOrder < ApplicationRecord
  belongs_to :provider
  belongs_to :employee
  has_many :purchase_order_items, dependent: :delete_all
  accepts_nested_attributes_for :purchase_order_items, :allow_destroy => true
  extend Enumerize
  enumerize :state, in: [:created, :received, :invoiced]

  def self.create_purchase_order(budget_items)
    budget_items.each do |item|
      request_id = item.budget_request.purchase_request_id
      @purchase_order = PurchaseOrder.find_or_create_by(provider_id: item.budget_request.provider_id, purchase_request_id: request_id ) do |order|
        order.provider_id = item.budget_request.provider_id
        order.employee_id = 1
        order.date = Time.now
        order.state = :created
        order.purchase_request_id = request_id
        if PurchaseOrder.any?
          order.number = PurchaseOrder.last.number + 1
        else
          order.number = 1
        end
      end
      if @purchase_order
        #@purchase_request_items = @purchase_order.purchase_order_items.create(product_id: 1, price: 10000, requested_quantity: 5, received_quantity: 0)
        @purchase_request_items = @purchase_order.purchase_order_items.create(product_id: item.product_id, price: item.price, requested_quantity: item.requested_quantity, received_quantity: 0)
      end
    end
  end

  filterrific :default_filter_params => {:sorted_by => 'date_asc'},
              :available_filters => %w[
                  sorted_by
                  search_query
                  with_date_gte
                  with_date_lt
    ]
  # default for will_paginate
  self.per_page = 10

  scope :search_query, ->(query) {
    return nil if query.blank?
    # condition query, parse into individual keywords
    terms = query.to_s.downcase.split(/\s+/)
    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map { |e| ('%'+e.gsub('*','%')+'%').gsub(/%+/, '%') }
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conditions = 2
    where(
        terms.map {
          or_clauses = [
              "LOWER(people.name) LIKE ?",
              "LOWER(purchase_orders.comment) LIKE ?"
          ].join(' OR ')
          "(#{ or_clauses })"
        }.join(' AND '),
        *terms.map {|e| [e] * num_or_conditions}.flatten
    ).joins(provider: :person).references(:people)
  }

  scope :sorted_by, ->(sort_option) {
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    purchase_orders = PurchaseOrder.arel_table
    case sort_option.to_s
    when /^date_/
      order(purchase_orders[:date].send(direction))
    else
      raise(ArgumentError, "Invalid sort option: #{sort_option.inspect}")
    end
  }

  scope :with_date_gte, ->(ref_date) {
    where("purchase_orders.date >= ?", ref_date)
  }

  scope :with_date_lt, ->(ref_date) {
    where('purchase_orders.date <= ?', ref_date)
  }

  def self.options_for_sorted_by
    [
        ['Fecha (viejos primero)', 'date_asc'],
        ['Fecha (recientes primero)', 'date_desc']
    ]
  end

end
