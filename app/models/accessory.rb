class Accessory < ApplicationRecord
  belongs_to :user
  has_many :extractions
end
