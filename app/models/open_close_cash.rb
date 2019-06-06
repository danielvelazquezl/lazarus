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
end
