class PurchaseInvoice < ApplicationRecord
  belongs_to :provider
  belongs_to :employee
  belongs_to :deposit
  belongs_to :purchase_order
  has_many :purchase_invoice_items
  accepts_nested_attributes_for :purchase_invoice_items, :allow_destroy => true

  after_save :update_stock

  private

  def update_stock
    begin
      PurchaseInvoice.transaction do
        purchase_invoice_items.each do |si|
          quantity = si.quantity
          product_id = si.product_id

          @stock_origin = Stock.where(deposit_id: self.deposit, product_id: product_id).first
          @stock_origin.increase_stock!(quantity)

        end
      end
    rescue StandardError => e
      self.errors.add(:quantity, "Cantidad insuficiente para realizar esta transaccion")
      raise ActiveRecord::RecordInvalid.new(self)
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
    num_or_conditions = 1
    where(
        terms.map {
          or_clauses = [
              "LOWER(people.name) LIKE ?"
          ].join(' OR ')
          "(#{ or_clauses })"
        }.join(' AND '),
        *terms.map {|e| [e] * num_or_conditions}.flatten
    ).joins(provider: :person).references(:people)
  }

  scope :sorted_by, ->(sort_option) {
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    purchase_invoices = PurchaseInvoice.arel_table
    case sort_option.to_s
    when /^date_/
      order(purchase_invoices[:date].send(direction))
    else
      raise(ArgumentError, "Invalid sort option: #{sort_option.inspect}")
    end
  }

  scope :with_date_gte, ->(ref_date) {
    where("purchase_invoices.date >= ?", ref_date)
  }

  scope :with_date_lt, ->(ref_date) {
    where('purchase_invoices.date <= ?', ref_date)
  }

  def self.options_for_sorted_by
    [
        ['Fecha (viejos primero)', 'date_asc'],
        ['Fecha (recientes primero)', 'date_desc']
    ]
  end
  resourcify
end
