class Employee < ApplicationRecord
  belongs_to :person, :dependent => :delete
  belongs_to :user
  has_many :open_close_cashes

  extend Enumerize
    enumerize :sex, in: [:male, :female]
    enumerize :charge, in: [:cashier, :warehouse_manager, :seller, :manager]

end
