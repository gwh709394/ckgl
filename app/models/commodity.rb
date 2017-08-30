class Commodity < ApplicationRecord
  validates :name, presence: true
  belongs_to :commodity_type
  has_many :stocks
  has_many :commodity_warehouse_relationships
  before_save :set_default
  
  def set_default
    self.cost ||= 0.00
    self.sale ||= 0.00
    if self.bar_code.nil? || self.bar_code.blank?
      if Commodity.where.not(bar_code: '').where.not(bar_code:nil).last.bar_code.present?
        Rails.logger.info("#{Commodity.where.not(bar_code: '').where.not(bar_code:nil).last.id}")
        Rails.logger.info("#{Commodity.where.not(bar_code: '').where.not(bar_code:nil).last.bar_code}")
        num = Commodity.where.not(bar_code: '').where.not(bar_code:nil).last.bar_code.split('CKGL')[1].to_i
        self.bar_code = "CKGL#{(num + 1).to_s}"
      else
        self.bar_code = "CKGL10001"
      end
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
