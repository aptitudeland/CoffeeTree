class Tasting < ApplicationRecord
  belongs_to :extraction
  belongs_to :user
  has_many :flavors
end
