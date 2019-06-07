class BudgetRequest < ApplicationRecord
  belongs_to :provider
  belongs_to :employee
  belongs_to :purchase_request
  has_many :budget_request_items, dependent: :delete_all
  accepts_nested_attributes_for :budget_request_items, :allow_destroy => true

  extend Enumerize

  enumerize :state, in: [:created, :finished]


  def self.get_cheapest_items(purchase_request)
    budget_requests = BudgetRequest.where("purchase_request_id = ? and state = ?", purchase_request.id, :finished)
    budget_items = []
    budget_requests.each do |item|
      budget_items.concat( BudgetRequestItem.joins(:budget_request).where("budget_request_id = ?", item.id))
    end
    #budget_items = BudgetRequestItem.joins(:budget_request).where("budget_request_id = ?", self.id)
    sorted_items = budget_items.sort_by { |bi| bi.price }
    cheapest_products = sorted_items.uniq { |ch| ch.product_id }
    return cheapest_products
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
    ).joins(employee: :person).references(:people)
  }

  scope :sorted_by, ->(sort_option) {
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    budget_requests = BudgetRequest.arel_table
    case sort_option.to_s
    when /^date_/
      order(budget_requests[:date].send(direction))
    else
      raise(ArgumentError, "Invalid sort option: #{sort_option.inspect}")
    end
  }

  scope :with_date_gte, ->(ref_date) {
    where("budget_requests.date >= ?", ref_date)
  }

  scope :with_date_lt, ->(ref_date) {
    where('budget_requests.date <= ?', ref_date)
  }

  def self.options_for_sorted_by
    [
        ['Fecha (viejos primero)', 'date_asc'],
        ['Fecha (recientes primero)', 'date_desc']
    ]
  end
end