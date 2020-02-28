class Role < ApplicationRecord
has_and_belongs_to_many :users, :join_table => :users_roles, dependent: :delete_all
has_many :permissions, dependent: :delete_all
accepts_nested_attributes_for :permissions, :allow_destroy => true



belongs_to :resource,
           :polymorphic => true,
           :optional => true


validates :resource_type,
          :inclusion => { :in => Rolify.resource_types },
          :allow_nil => true

scope :all_role, ->{where.not(name: "admin")}

scopify

end
