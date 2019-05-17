class User < ApplicationRecord
  has_many :movement_proof
  resourcify
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  scope :all_user, ->{where.not(user_name: "admin")}
end
