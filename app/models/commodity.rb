class Commodity < ApplicationRecord
  validates :name, presence: true
  belongs_to :commodity_type
  has_many :stocks
  has_many :commodity_warehouse_relationships
  before_save :set_default
  
  def set_default
    self.cost ||= 0.00
    self.sale ||= 0.00
  end
  
  def self.query q
    s = "%#{q}%"
    Commodity.where('name like ?', s)
  end
end
