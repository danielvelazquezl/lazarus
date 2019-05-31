class Provider < ApplicationRecord
  belongs_to :person, :dependent => :delete
end
