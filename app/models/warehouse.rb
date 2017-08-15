class Warehouse < ApplicationRecord
	validates :name, presence: true
  has_many :documents
end
