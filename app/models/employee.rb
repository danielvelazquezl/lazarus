class Employee < ApplicationRecord
  belongs_to :person, :dependent => :delete
  belongs_to :user
  has_many :open_close_cashes
end
