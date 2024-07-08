class Coffee < ApplicationRecord
  has_many :varieties
  has_many :user_coffees
  has_many :users, through: :user_coffees
  has_many :extractions
end
