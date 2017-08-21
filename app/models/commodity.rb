class Commodity < ApplicationRecord
  validates :name, presence: true
  belongs_to :commodity_type
  has_many :stocks
  has_many :commodity_warehouse_relationships
  before_save :set_default
  
  def set_default
    self.cost ||= 0.00
    self.sale ||= 0.00
    if self.code.nil?
      if Commodity.last.code.present?
        self.code = Commodity.last.code +1
      else
        self.code = 10001
      end
      self.bar_code = "CK#{self.code}"
    end
  end
  
  def self.barcode bc
    Commodity.where(bar_code: bc)
  end
  
  def self.query q
    s = "%#{q}%"
    Commodity.where('name like ?', s)
  end
end
