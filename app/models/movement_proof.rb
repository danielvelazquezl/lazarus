class MovementProof < ApplicationRecord
  acts_as_paranoid

  belongs_to :person
  belongs_to :deposit
  belongs_to :movement_type
  has_many :movement_proof_details

  before_save :update_stock

  accepts_nested_attributes_for :movement_proof_details

  private

  def update_stock

    begin
      Order.transaction do
        movement_proof_details.each do |mpd|
          quantity = mpd.quantity
          product_id = mpd.product_id
          action = mpd.movement_proof.movement_type.action

          @stock = Stock.where(deposit_id: self.deposit_id, product_id: product_id).first

          if is_reduce?(action)
            @stock.reduce_stock!(product_id, quantity)

          elsif is_increase?(action)
            @stock.increase_stock!(quantity)

          end
        end
      end

    rescue StandardError => e

      self.errors.add(:quantity, "Cantidad insuficiente para realizar esta transaccion")
      raise ActiveRecord::RecordInvalid.new(self)

    end
  end

  def is_increase?(action)
    action == '+'
  end

  def person
    Person.unscoped { super }
  end


  def is_reduce?(action)
    action == '-'
  end

  filterrific :default_filter_params => {:sorted_by => 'deposit_asc'},
              :available_filters => %w[
                  sorted_by
                  search_query
                  with_deposit_id
                  with_person_id
                  with_created_at_gte
                ]

  # default for will_paginate
  self.per_page = 10

  scope :search_query, lambda { |query|
    return nil  if query.blank?
    # condition query, parse into individual keywords
    terms = query.downcase.split(/\s+/)
    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map { |e|
      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conditions = 1
    where(
        terms.map {
          or_clauses = [
              "LOWER(movement_types.description) LIKE ?"
          ].join(' OR ')
          "(#{ or_clauses })"
        }.join(' AND '),
        *terms.map { |e| [e] * num_or_conditions }.flatten
    ).joins(:movement_type).references(:movement_types)
  }

  scope :sorted_by, ->(sort_option) {
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    deposits = Deposit.arel_table
    movements = MovementProof.arel_table
    persons = Person.arel_table
    movement_types = MovementType.arel_table
    case sort_option.to_s
    when /^created_at_/
      order(movements[:created_at].send(direction))
    when /^movement_type_/
      MovementProof.joins(:movement_type).order(movement_types[:description].lower.send(direction)).order(movements[:created_at].send(direction))
    when /^person_/
      MovementProof.joins(:person).order(persons[:name].lower.send(direction)).order(movements[:created_at].send(direction))
    when /^deposit_/
      MovementProof.joins(:deposit).order(deposits[:description].lower.send(direction)).order(movements[:created_at].send(direction))
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

  scope :with_movement_type_id, ->(movement_type_ids) {
    where(:movement_type_id => [*movement_type_ids])
  }

  scope :with_created_at_gte, ->(ref_date) {
    where('movement_proofs.created_at >= ?', ref_date)
  }

  delegate :description, :to => :deposit, :prefix => true
  delegate :name, :to => :person, :prefix => true
  delegate :description, :to => :movement_type, :prefix => true

  def self.options_for_sorted_by
    [
        ['Deposito (ascendente)', 'deposit_asc'],
        ['Deposito (descendente)', 'deposit_desc'],
        ['Encargado (ascendente)', 'person_asc'],
        ['Encargado (descendente)', 'person_desc'],
        ['Fecha (recientes primero)', 'created_at_desc'],
        ['Fecha (viejos primero)', 'created_at_asc']
    ]
  end

end
