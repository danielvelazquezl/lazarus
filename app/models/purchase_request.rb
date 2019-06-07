class PurchaseRequest < ApplicationRecord
  after_update :generate_budget_request

  belongs_to :employee
  has_many :budget_requests
  has_many :purchase_request_items, dependent: :delete_all
  accepts_nested_attributes_for :purchase_request_items, :allow_destroy => true

  extend Enumerize

  enumerize :state, in: [:generated, :pending, :finished, :invoiced, :uninvoiced]


  private

  def generate_budget_request
    employee_id = self.employee_id
    purchase_request_id = self.id

    purchase_request_items.each do |pr|
      product_id = pr.product_id
      @product = Product.where(id: product_id).first
      category_id = @product.product_category_id
      requested_quantity = pr.quantity

      @provider_category_list = ProviderCategory.where(product_category_id: category_id)

      @provider_category_list.each do |pc|
        provider_category_id = pc.product_category_id
        provider_id = pc.provider_id

        if provider_category_id == category_id
          @budget_request = BudgetRequest.find_or_create_by(provider_id: provider_id, purchase_request_id: purchase_request_id) do |budget_request|
            budget_request.employee_id = employee_id
            budget_request.date = Time.now
            budget_request.state = :created
            budget_request.purchase_request_id = purchase_request_id
          end

          if @budget_request
            @budget_request_items = @budget_request.budget_request_items.find_or_create_by(product_id: product_id) do |bri|
              bri.requested_quantity = requested_quantity
            end
          end
        end

      end
    end
  end

  def self.modify_purchase_request(product_id, stock_quantity, min_stock_quantity, quantity)
    new_quantity = stock_quantity - quantity

    if new_quantity <= min_stock_quantity
      @purchase_request = PurchaseRequest.find_or_create_by(date: Time.now.midnight.to_formatted_s(:db)) do |purchase_request|
        purchase_request.employee_id = 1
        purchase_request.state = :pending

        if PurchaseRequest.any?
          purchase_request.number = PurchaseRequest.last.number + 1
        else
          purchase_request.number = 1
        end
      end

      if @purchase_request
        @purchase_request_items = @purchase_request.purchase_request_items.find_or_create_by(product_id: product_id, quantity: min_stock_quantity)
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
              "LOWER(purchase_requests.comment) LIKE ?"
          ].join(' OR ')
          "(#{ or_clauses })"
        }.join(' AND '),
        *terms.map {|e| [e] * num_or_conditions}.flatten
    ).joins(employee: :person).references(:people)
  }

  scope :sorted_by, ->(sort_option) {
  # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    purchase_requests = PurchaseRequest.arel_table
    case sort_option.to_s
    when /^date_/
      order(purchase_requests[:date].send(direction))
    else
      raise(ArgumentError, "Invalid sort option: #{sort_option.inspect}")
    end
  }

  scope :with_date_gte, ->(ref_date) {
    where("purchase_requests.date >= ?", ref_date)
  }

  scope :with_date_lt, ->(ref_date) {
    where('purchase_requests.date <= ?', ref_date)
  }

  def self.options_for_sorted_by
    [
        ['Fecha (viejos primero)', 'date_asc'],
        ['Fecha (recientes primero)', 'date_desc']
    ]
  end
end


