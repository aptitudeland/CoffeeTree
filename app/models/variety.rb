class Variety < ApplicationRecord
  has_many :coffee_varieties, dependent: :destroy
  has_many :coffees, through: :coffee_varieties
end
