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
    movement_proof_details.each do |mpd|


      quantity = mpd.quantity
      product_id = mpd.product_id
      action = mpd.movement_proof.movement_type.action

      Stock.modify_stock(product_id, self.deposit_id, quantity, action)
      # stock = stock.where(product_id:product_id).first
      # stock = Stock.where("deposit_id = ? and product_id = ?", self.deposit_id, product_id).first
      # current_quantity = stock.quantity
      #
      # if action == '-'
      #   new_quantity = current_quantity - quantity
      #
      #
      # elsif action == '+'
      #   new_quantity = current_quantity + quantity
      # end
      #
      # stock.update_attributes(quantity:new_quantity)

    end
  end

  def person
    Person.unscoped { super }
  end

end
