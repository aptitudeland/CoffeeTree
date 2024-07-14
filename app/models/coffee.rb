class Coffee < ApplicationRecord
  attr_accessor :altitude
  before_validation :set_altitude
  
  has_many :coffee_varieties, dependent: :destroy
  has_many :varieties, through: :coffee_varieties
  has_many :user_coffees
  has_many :users, through: :user_coffees
  has_many :extractions

  validates :name, presence: true, uniqueness: true

  def coffee_description
    "#{self.attributes['name']} - #{self.attributes['roaster']} - #{self.attributes['roasting_date']} - #{self.attributes['country']}"
  end

  def country_name
    country = ISO3166::Country[self.attributes['country']]
    if country
      country.translations[I18n.locale.to_s] || country.common_name || country.iso_short_name
    else
      self.attributes['country']
    end
  end

  private

  def set_altitude
    unless altitude.nil?
      self.altitude_low = altitude
      self.altitude_high = altitude
    end
  end
end
