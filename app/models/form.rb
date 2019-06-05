class Form < ApplicationRecord

  after_save :update_stock

  belongs_to :person
  belongs_to :origin, :class_name => 'Deposit'
  belongs_to :destination, :class_name => 'Deposit'
  has_many :form_items, dependent: :delete_all
  accepts_nested_attributes_for :form_items, :allow_destroy => true

  extend Enumerize

  enumerize :form_type, in: [:cpuproduced , :keyboardmonitorrequest]

  scope :cpuproduced_form, ->{where(form_type: :cpuproduced)}
  scope :keyboardmonitorrequest_form, ->{where(form_type: :keyboardmonitorrequest)}


  private
  def update_stock
    begin
      Order.transaction do
        form_items.each do |ft|
          quantity = ft.quantity
          product_id = ft.product_id

          @stock_origin = Stock.where(deposit_id: self.origin, product_id: product_id).first
          @stock_origin.reduce_stock!(product_id, quantity)

          @stock_destination = Stock.where(deposit_id: self.destination, product_id: product_id).first
          @stock_destination.increase_stock!(quantity)
        end
      end

    rescue StandardError => e

      self.errors.add(:quantity, "Cantidad insuficiente para realizar esta transaccion")
      raise ActiveRecord::RecordInvalid.new(self)
    end
  end

  filterrific :default_filter_params => {:sorted_by => 'created_at_asc'},
              :available_filters => %w[
                  sorted_by
                  search_query
                  with_created_at_gte
                  with_person_id
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
    forms = Form.arel_table
    persons = Person.arel_table
    case sort_option.to_s
    when /^created_at_/
      order(forms[:date].send(direction))
    when /^finish_at_/
      order(forms[:date].send(direction))
    when /^person_/
      Form.joins(:person).order(persons[:name].lower.send(direction)).order(forms[:date].send(direction))
    when /^state_/
      order(orders[:state]).send(direction)
    else
      raise(ArgumentError, "Invalid sort option: #{sort_option.inspect}")
    end
  }

  scope :with_deposit_id, ->(deposit_ids) {
    where(:deposit_id => [*deposit_ids])
  }

  scope :with_person_id, ->(person_ids) {
    where(:person_id => [*person_ids])
  }

  scope :with_created_at_gte, ->(ref_date) {
    where('forms.date >= ?', ref_date)
  }

  delegate :name, :to => :person, :prefix => true

  def self.options_for_sorted_by
    [
        ['Fecha (viejos primero)', 'created_at_asc'],
        ['Fecha (recientes primero)', 'created_at_desc'],
        ['Encargado (ascendente)', 'person_asc'],
        ['Encargado (descendente)', 'person_desc']
    ]
  end
end
