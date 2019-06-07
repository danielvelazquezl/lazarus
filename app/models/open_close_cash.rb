class OpenCloseCash < ApplicationRecord
  belongs_to :cash
  belongs_to :employee
  scope :all_open,->{where(state: true)}
  #scope :all_close, ->{joins(:cash).where("cash.state = ?", false)}
  scope :all_close,->{where(state: false)}

  scope :amount_open_cashes_bill, ->(cash_id) {where(cash_id: cash_id, state: true).sum("bill_amount")}
  scope :amount_open_cashes_check, ->(cash_id) {where(cash_id: cash_id, state: true).sum("check_amount")}
  scope :amount_open_cashes_card, ->(cash_id) {where(cash_id: cash_id, state: true).sum("card_amount")}

  scope :update_open_cashes_bill, ->(cash_id, amount) {where(cash_id: cash_id, state: true).update_all(bill_amount: amount)}
  scope :update_open_cashes_check, ->(cash_id, amount) {where(cash_id: cash_id, state: true).update_all(check_amount: amount)}
  scope :update_open_cashes_card, ->(cash_id, amount) {where(cash_id: cash_id, state: true).update_all(card_amount: amount)}

  scope :update_open_cash_final_ammount, ->(cash_id,amount) {where(cash_id: cash_id, state:true).update_all(final_ammount: amount)}

  scope :cashes_closed, -> { where(state: true) }

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
              "LOWER(people.name) LIKE ?"
          ].join(' OR ')
          "(#{ or_clauses })"
        }.join(' AND '),
        *terms.map {|e| [e] * num_or_conditions}.flatten
    ).joins(client: :person).references(:people, :clients)
  }

  scope :sorted_by, ->(sort_option) {
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    opens = OpenCloseCash.arel_table
    persons = Person.arel_table
    case sort_option.to_s
    when /^date_/
      order(opens[:date_start].send(direction))
    when /^person_/
      OpenCloseCash.joins(client: :person).order(persons[:name].lower.send(direction)).order(opens[:created_at].send(direction))
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

end
