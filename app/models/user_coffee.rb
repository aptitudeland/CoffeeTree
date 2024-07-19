class UserCoffee < ApplicationRecord
  BAG_WEIGHTS = [250, 500, 1000]

  before_validation :set_weight_left

  belongs_to :user
  belongs_to :coffee
  has_many :extractions

  validates :bag_weight, presence: true, numericality: { greater_than: -1 }
  validates :weight_left, presence: true, numericality: { greater_than: -1 }
  accepts_nested_attributes_for :coffee

  def name
    coffee.name
  end

  def coffee_details
    # "#{coffee.roaster} | #{coffee.name} | #{coffee.roasting_date} | #{remaining_quantity} gr left"
    "#{coffee.roaster} | #{coffee.name} | #{coffee.roasting_date}"
  end

  def remaining_quantity
    total_weight_in = extractions.sum(:weight_in)
    bag_weight - total_weight_in
  end

  private

  def set_weight_left
    self.weight_left = self.attributes['bag_weight']
  end
end
