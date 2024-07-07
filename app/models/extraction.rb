class Extraction < ApplicationRecord
  belongs_to :coffee
  belongs_to :user_coffee
  belongs_to :user
  belongs_to :user_accessory
  has_many :tastings
end
