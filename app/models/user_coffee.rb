class UserCoffee < ApplicationRecord
  BAG_WEIGHTS = [250, 500, 1000]

  before_create :set_weight_left
  before_update :check_weight_left

  belongs_to :user
  belongs_to :coffee
  has_many :extractions

  validates :bag_weight, presence: true, numericality: { greater_than: -1 }
  accepts_nested_attributes_for :coffee

  scope :active, ->{ where(archived: nil) }

  def name
    coffee.name
  end

  private

  def set_weight_left
    self.weight_left = self.attributes['bag_weight']
  end

  def check_weight_left
    if self.weight_left <= 0
      self.weight_left = 0
      self.archived = true
    end
  end
end
