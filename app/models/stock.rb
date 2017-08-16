class Stock < ApplicationRecord
  belongs_to :document
  belongs_to :commodity
  paginates_per 15
  def self.query s
    q = "%#{s}%"
    a = Commodity.where('name like ?', q).map { |x| x.id }
    Stock.where('commodity_id in (?)', a)
  end
end
