class OpenCloseCash < ApplicationRecord
  belongs_to :cash
  belongs_to :employee
  scope :all_open,->{where(state: true)}
  #scope :all_close, ->{joins(:cash).where("cash.state = ?", false)}
  scope :all_close,->{where(state: false)}
end
