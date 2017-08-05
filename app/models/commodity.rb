class Commodity < ApplicationRecord
  validates :name, presence: true
  belongs_to :commodity_type
end
