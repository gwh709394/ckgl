class CommodityType < ApplicationRecord
	validates :name, presence: true
  has_many :commodities
end
