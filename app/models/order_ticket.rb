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
order_tickets = OrderTicket.arel_table
case sort_option.to_s
when /^date_/
order(order_tickets[:date].send(direction))
else
raise(ArgumentError, "Invalid sort option: #{sort_option.inspect}")
end
}

def self.options_for_sorted_by
[
['Fecha (viejos primero)', 'date_asc'],
['Fecha (recientes primero)', 'date_desc']
]
end
end
