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


end
