class Provider < ApplicationRecord
  belongs_to :person, :dependent => :delete
  has_many :provider_categories, dependent: :delete_all

  accepts_nested_attributes_for :provider_categories, :allow_destroy => true
end
