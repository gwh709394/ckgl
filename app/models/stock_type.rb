class StockType < ApplicationRecord
	validates :name, presence: true
end
