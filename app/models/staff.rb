class Staff < ApplicationRecord
  validates :name, presence: true
  has_many :docuemnts
end
