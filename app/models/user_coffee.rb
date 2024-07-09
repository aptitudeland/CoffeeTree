class UserCoffee < ApplicationRecord
  after_validation :set_weight_left

  belongs_to :user
  belongs_to :coffee
  has_many :extractions

  validates :bag_weight, presence: true
  accepts_nested_attributes_for :coffee

  private

  def set_weight_left
    if self.attributes['weight_left'].nil?
      self.attributes['weight_left'] = self.attributes['bag_weight']
    end
  end
end
