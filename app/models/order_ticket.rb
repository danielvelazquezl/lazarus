class OrderTicket < ApplicationRecord
  belongs_to :client
  belongs_to :employee
  has_many :order_ticket_items, dependent: :delete_all
  has_many :sales_invoices
  accepts_nested_attributes_for :order_ticket_items, :allow_destroy => true

  extend Enumerize

  enumerize :state, in: [:invoiced, :uninvoiced]

  filterrific :default_filter_params => {:sorted_by => 'date_asc'},
              :available_filters => %w[
                  sorted_by
                  search_query
                  with_employee_id
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
    num_or_conditions = 2
    where(
        terms.map {
          or_clauses = [
              "LOWER(people.name) LIKE ?",
              "LOWER(clients.ruc) LIKE ?"
          ].join(' OR ')
          "(#{ or_clauses })"
        }.join(' AND '),
        *terms.map {|e| [e] * num_or_conditions}.flatten
    ).joins(client: :person).references(:people, :clients, :employees)
  }

  scope :sorted_by, ->(sort_option) {
  # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    order_tickets = OrderTicket.arel_table
    persons = Person.arel_table
    case sort_option.to_s
    when /^date_/
      order(order_tickets[:date].send(direction))
    when /^person_/
      OrderTicket.joins(employee: :person).order(persons[:name].lower.send(direction)).order(order_tickets[:created_at].send(direction))
    when /^person2_/
      OrderTicket.joins(client: :person).order(persons[:name].lower.send(direction)).order(order_tickets[:created_at].send(direction))
    else
      raise(ArgumentError, "Invalid sort option: #{sort_option.inspect}")
    end
  }

  delegate :name, :to => :person, :prefix => true

  scope :with_employee_id, ->(employee_ids) {
    where(:employee_id => [*employee_ids])
  }

  def self.options_for_sorted_by
    [
        ['Fecha (viejos primero)', 'date_asc'],
        ['Fecha (recientes primero)', 'date_desc'],
        ['Encargado (ascendente)', 'person_asc'],
        ['Encargado (descendente)', 'person_desc'],
        ['Cliente (ascendente)', 'person2_asc'],
        ['Cliente (descendente)', 'person2_desc']
    ]
  end
end
