class Coffee < ApplicationRecord
  attr_accessor :altitude

  before_validation :set_altitude

  has_many :coffee_varieties
  has_many :varieties, through: :coffee_varieties
  has_many :user_coffees
  has_many :users, through: :user_coffees
  has_many :extractions

  private

  def set_altitude
    puts self
    if self.attributes['altitude'].not.nil?
      self.attributes['altitude_low'] = self.attributes['altitude']
      self.attributes['altitude_high'] = self.attributes['altitude']
    end
  end
end
