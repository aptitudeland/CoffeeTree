class Accessory < ApplicationRecord
  BREWING_METHODS = [
    'Aero press',
    'Cold brew',
    'Drip coffee',
    'Espresso',
    'French press',
    'Moka Pot',
    'Pour-Over',
    'Siphon coffee',
    'Turkish coffee',
    'Vietnamese Phin'
  ]

  ACCESSORY_TYPES = [
    'Grinder',
    'Scale',
    'Basket',
    'Tamper',
    'Filter',
    'Kettle',
    'Distribution Tool',
    'Other'
  ] + BREWING_METHODS

  belongs_to :user

  has_and_belongs_to_many :extractions

  validates :name, presence: true
  validates :accessory_type, presence: true
  validates :grinder_min, presence: true, if: -> { accessory_type == 'Grinder' }
  validates :grinder_max, presence: true, if: -> { accessory_type == 'Grinder' }

  before_save :ensure_single_default

  def self.image_path(type)
    "accessories/#{type.parameterize(separator: '_')}_small.png"
  end

  private

  def ensure_single_default
    if self.default
      Accessory.where(user_id: self.user_id, accessory_type: self.accessory_type, default: true).where.not(id: self.id).update_all(default: false)
    end
  end
end
