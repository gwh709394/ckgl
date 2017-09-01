class CommodityType < ApplicationRecord
  acts_as_paranoid
	validates :name, presence: true
  has_many :commodities
end
