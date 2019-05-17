class Permission < ApplicationRecord
  belongs_to :type_action
  belongs_to :role
  belongs_to :resource
end
