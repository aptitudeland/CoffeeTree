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

  private

  def set_altitude
    unless altitude.nil?
      self.altitude_low = altitude
      self.altitude_high = altitude
    end
  end
end
