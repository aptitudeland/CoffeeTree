class Variety < ApplicationRecord
  has_many :coffee_varieties
  has_many :coffees, through: :coffee_varieties
end
