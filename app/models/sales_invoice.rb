class SalesInvoice < ApplicationRecord
  belongs_to :employee
  belongs_to :client
  belongs_to :deposit
  belongs_to :order_ticket
  has_many :cash_movement_invoices
  belongs_to :stamped
  has_many :sales_invoices_items
  accepts_nested_attributes_for :sales_invoices_items, :allow_destroy => true

  scope :find_by_client, ->(id) {where(client_id: id)}
  scope :update_invoices_balance, ->(invoices_id, amount) {where(id: invoices_id).update_all(balance: amount)}

  after_save :update_stock

  private

  def update_stock
    # sales_invoices_items.each do |si|
    #   quantity = si.quantity
    #   product_id = si.product_id
    #
    #   Stock.reduce_stock(product_id, self.deposit, quantity)
    #
    begin
      SalesInvoice.transaction do

        sales_invoices_items.each do |si|
          quantity = si.quantity
          product_id = si.product_id

          @stock_origin = Stock.where(deposit_id: self.deposit, product_id: product_id).first
          @stock_origin.reduce_stock!(product_id, quantity)

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
    num_or_conditions = 3
    where(
        terms.map {
          or_clauses = [
              "LOWER(people.name) LIKE ?",
              "LOWER(stampeds.name) LIKE ?",
              "CAST(sales_invoices.invoice_number AS CHAR VARYING) LIKE ?"
          ].join(' OR ')
          "(#{ or_clauses })"
        }.join(' AND '),
        *terms.map {|e| [e] * num_or_conditions}.flatten
    ).joins({client: :person}, :stamped).references(:people, :clients, :stampeds)
  }

  scope :sorted_by, ->(sort_option) {
  # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    sales_invoices = SalesInvoice.arel_table
    persons = Person.arel_table
    case sort_option.to_s
    when /^date_/
      order(sales_invoices[:date].send(direction))
    when /^person_/
      SalesInvoice.joins(client: :person).order(persons[:name].lower.send(direction)).order(sales_invoices[:created_at].send(direction))
    else
      raise(ArgumentError, "Invalid sort option: #{sort_option.inspect}")
    end
  }

  scope :with_date_gte, ->(ref_date) {
    where("sales_invoices.date >= ?", ref_date)
  }

  scope :with_date_lt, ->(ref_date) {
    where('sales_invoices.date <= ?', ref_date)
  }

  def self.options_for_sorted_by
    [
        ['Fecha (viejos primero)', 'date_asc'],
        ['Fecha (recientes primero)', 'date_desc'],
        ['Cliente (ascendente)', 'person_asc'],
        ['Cliente (descendente)', 'person_desc']
    ]
  end
  resourcify
end



