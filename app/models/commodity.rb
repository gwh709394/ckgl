class Commodity < ApplicationRecord
  validates :name, presence: true
  belongs_to :commodity_type
  
  before_save :set_default
  
  def set_default
    self.cost ||= 0.00
    self.sale ||= 0.00
  end
end
