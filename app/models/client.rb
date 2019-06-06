class Client < ApplicationRecord
  belongs_to :person, :dependent => :delete
  has_many :client_cash_movements, :class_name => 'CashMovement', foreign_key: 'client_id'

  filterrific :default_filter_params => {:sorted_by => 'created_at_asc'},
              :available_filters => %w[
                  sorted_by
                  search_query
                  with_created_at_gte
                ]

  # default for will_paginate
  self.per_page = 10

  scope :search_query, ->(query) {
    return nil if query.blank?
    # condition query, parse into individual keywords
    terms = query.to_s.downcase.split(/\s+/)
    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map {|e|
      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conditions = 3
    where(
        terms.map {
          or_clauses = [
              "LOWER(people.name) LIKE ?",
              "LOWER(people.email) LIKE ?",
              "LOWER(clients.ruc) LIKE ?"
          ].join(' OR ')
          "(#{ or_clauses })"
        }.join(' AND '),
        *terms.map {|e| [e] * num_or_conditions}.flatten
    ).joins(:person).references(:people)
  }

  scope :sorted_by, ->(sort_option) {
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    clients = Client.arel_table
    persons = Person.arel_table
    case sort_option.to_s
    when /^created_at_/
      order(clients[:created_at].send(direction))
    when /^ruc_/
      order(clients[:ruc].send(direction))
    when /^email_/
      Client.joins(:person).order(persons[:email].lower.send(direction)).order(clients[:created_at].send(direction))
    when /^person_/
      Client.joins(:person).order(persons[:name].lower.send(direction)).order(clients[:created_at].send(direction))
    else
      raise(ArgumentError, "Invalid sort option: #{sort_option.inspect}")
    end
  }

  scope :with_person_id, ->(person_ids) {
    where(:person_id => [*person_ids])
  }

  scope :with_created_at_gte, ->(ref_date) {
    where('employees.created_at >= ?', ref_date)
  }

  delegate :name, :to => :person, :prefix => true
  delegate :email, :to => :person, :prefix => true

  def self.options_for_sorted_by
    [
        ['Nombre (ascendente)', 'person_asc'],
        ['Nombre (descendente)', 'person_desc'],
        ['Correo (ascendente)', 'email_asc'],
        ['Correo (descendente)', 'email_desc'],
        ['R.U.C (ascendente)', 'ruc_asc'],
        ['R.U.C (descendente)', 'ruc_desc']
    ]
  end

end
