class Role < ApplicationRecord
has_and_belongs_to_many :users, :join_table => :users_roles, dependent: :delete_all


has_many :permission, dependent: :delete_all

belongs_to :resource,
           :polymorphic => true,
           :optional => true


validates :resource_type,
          :inclusion => { :in => Rolify.resource_types },
          :allow_nil => true

scope :all_role, ->{where.not(name: "admin")}

scopify

end
