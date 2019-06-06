class Employee < ApplicationRecord
  belongs_to :person, :dependent => :delete
  belongs_to :user
  has_many :open_close_cashes

  extend Enumerize
    enumerize :sex, in: [:male, :female]
    enumerize :charge, in: [:cashier, :warehouse_manager, :seller, :manager]

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
              "(employees.ci) LIKE ?"
          ].join(' OR ')
          "(#{ or_clauses })"
        }.join(' AND '),
        *terms.map {|e| [e] * num_or_conditions}.flatten
    ).joins(:person).references(:people)
  }

  scope :sorted_by, ->(sort_option) {
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    employees = Employee.arel_table
    persons = Person.arel_table
    case sort_option.to_s
    when /^created_at_/
      order(employees[:created_at].send(direction))
    when /^ci_/
      order(employees[:ci].send(direction))
    when /^email_/
      Client.joins(:person).order(persons[:email].lower.send(direction)).order(clients[:created_at].send(direction))
    when /^person_/
      Employee.joins(:person).order(persons[:name].lower.send(direction)).order(employees[:created_at].send(direction))
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
      ['C.I (ascendente)', 'ci_asc'],
      ['C.I (descendente)', 'ci_desc']
    ]
  end

  def self.options_for_select
    persons = Person.arel_table
    employees = Employee.arel_table
    # order('LOWER(name)').map { |e| [e.name, e.id] }
    Employee.joins(:person).order(persons[:name].lower).pluck(:name, :id)
  end

  scope :products_from_d1, -> {joins(:stocks).merge(Stock.stock_from_d1)}

end
