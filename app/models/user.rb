class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_coffees
  has_many :coffees, through: :user_coffees
  has_many :extractions
  has_many :tastings
  has_many :accessories
end
