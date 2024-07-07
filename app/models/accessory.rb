class Accessory < ApplicationRecord
  belongs_to :user
  has_many :extractions

  ACCESSORY_TYPES = ['Grinder',"Espresso Machine", 'Filter', 'Kettle', 'Scale', 'Other']

  validates :accessory_type, inclusion: { in: ACCESSORY_TYPES }
end
