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

  scope :brewing_method, -> { where(accessory_type: Accessory::BREWING_METHODS) }
  scope :grinder, -> { where(accessory_type: 'Grinder') }
  scope :optionals, -> { where(accessory_type: ['Scale', 'Basket', 'Tamper', 'Filter', 'Kettle', 'Distribution Tool', 'Other']) }
  scope :scale, -> { where(accessory_type: 'Scale') }
  scope :basket, -> { where(accessory_type: 'Basket') }
  scope :tamper, -> { where(accessory_type: 'Tamper') }
  scope :filtering, -> { where(accessory_type: 'Filter') }
  scope :kettle, -> { where(accessory_type: 'Kettle') }
  scope :distribution_tool, -> { where(accessory_type: 'Distribution Tool') }
  scope :other, -> { where(accessory_type: 'Other') }

  def self.image_path(type)
    "accessories/#{type.parameterize(separator: '_')}_small.png"
  end

  private

  def ensure_single_default
    if self.default
      # Unset default for accessories of the same type
      Accessory.where(user_id: self.user_id, accessory_type: self.accessory_type, default: true).where.not(id: self.id).update_all(default: false)

      # Unset default for other brewing methods
      if BREWING_METHODS.include?(self.accessory_type)
        Accessory.where(user_id: self.user_id, accessory_type: BREWING_METHODS, default: true).where.not(id: self.id).update_all(default: false)
      end
    end
  end
end
