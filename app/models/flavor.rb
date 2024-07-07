class Flavor < ApplicationRecord
  belongs_to :tasting, optional: true
  validates :color_code, format: { with: /\A#(?:[0-9a-fA-F]{3}){1,2}\z/, message: "must be a valid hex color code" }

end
