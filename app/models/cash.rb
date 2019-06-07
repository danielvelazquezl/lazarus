class Cash < ApplicationRecord
  has_many :open_close_cash
  scope :all_open, ->{where(state: true)}
  scope :all_close, ->{where(state: false)}
  resourcify
end
