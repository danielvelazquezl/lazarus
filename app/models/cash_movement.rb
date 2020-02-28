class CashMovement < ApplicationRecord
  has_many :cash_movement_invoices
  has_many :cash_movement_values
  belongs_to :client
  belongs_to :cash
  accepts_nested_attributes_for :cash_movement_values, :allow_destroy => true
  accepts_nested_attributes_for :cash_movement_invoices, :allow_destroy => true

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
    terms = query.downcase.split(/\s+/)
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
              "LOWER(cash_movements.comments) LIKE ?"
          ].join(' OR ')
          "(#{ or_clauses })"
        }.join(' AND '),
        *terms.map {|e| [e] * num_or_conditions}.flatten
    ).joins(client: :person).references(:people, :clients)
  }

  scope :sorted_by, ->(sort_option) {
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    cash_movements = CashMovement.arel_table
    persons = Person.arel_table
    case sort_option.to_s
    when /^date_/
      order(cash_movements[:date].send(direction))
    when /^person_/
      CashMovement.joins(client: :person).order(persons[:name].lower.send(direction)).order(cash_movements[:created_at].send(direction))
    else
      raise(ArgumentError, "Invalid sort option: #{sort_option.inspect}")
    end
  }

  scope :with_date_gte, ->(ref_date) {
    where("cash_movements.date >= ?", ref_date)
  }

  scope :with_date_lt, ->(ref_date) {
    where('cash_movements.date <= ?', ref_date)
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
