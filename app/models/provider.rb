class Provider < ApplicationRecord
  belongs_to :person, :dependent => :delete
  has_many :provider_categories, dependent: :delete_all

  accepts_nested_attributes_for :provider_categories, :allow_destroy => true

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
    terms = terms.map { |e| ('%'+e.gsub('*','%')+'%').gsub(/%+/, '%') }
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conditions = 2
    where(
        terms.map {
          or_clauses = [
              "LOWER(people.name) LIKE ?",
              "LOWER(people.email) LIKE ?"
          ].join(' OR ')
          "(#{ or_clauses })"
        }.join(' AND '),
        *terms.map {|e| [e] * num_or_conditions}.flatten
    ).joins(:person).references(:people)
  }

  scope :sorted_by, ->(sort_option) {
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    providers = Provider.arel_table
    persons = Person.arel_table
    case sort_option.to_s
    when /^created_at_/
      order(providers[:created_at].send(direction))
    when /^charge_/
      order(providers[:charge].send(direction))
    when /^person_/
      Provider.joins(:person).order(persons[:name].lower.send(direction)).order(providers[:created_at].send(direction))
    else
      raise(ArgumentError, "Invalid sort option: #{sort_option.inspect}")
    end
  }

  scope :with_person_id, ->(person_ids) {
    where(:person_id => [*person_ids])
  }

  scope :with_created_at_gte, ->(ref_date) {
    where('providers.created_at >= ?', ref_date)
  }

  delegate :name, :to => :person, :prefix => true

  def self.options_for_sorted_by
    [
        ['Nombre (a-z)', 'person_asc'],
        ['Nombre (z-a)', 'person_desc']
    ]
  end
  resourcify
end
