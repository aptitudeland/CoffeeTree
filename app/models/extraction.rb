class Extraction < ApplicationRecord
  belongs_to :user
  belongs_to :coffee
  belongs_to :user_coffee
  has_and_belongs_to_many :accessories
  has_many :tastings
  validate :must_have_brewer

  private

  def must_have_brewer
    required_types = [
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
    unless accessories.any? { |a| required_types.include?(a.accessory_type) }
      errors.add(:accessories, "must include at least one brewer")
    end
  end
end
