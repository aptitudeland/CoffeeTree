class UserCoffee < ApplicationRecord
  belongs_to :user
  belongs_to :coffee
  has_many :extractions
end
