class Coffee < ApplicationRecord
  has_many :coffee_varieties
  has_many :varieties, through: :coffee_varieties
  has_many :user_coffees
  has_many :users, through: :user_coffees
  has_many :extractions
end
