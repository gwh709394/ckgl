class Document < ApplicationRecord
  belongs_to :staff
  belongs_to :warehouse
  has_many :stocks, dependent: :destroy
  paginates_per 15
  
  def self.set_number(s_type)
    a = StockType.where(s_type: s_type).map { |x| x.id}
    if s_type == StockingType::SHIPPING
      t = "CK"
    else
      t = "RK"   
    end
    d = Document.where("stock_type_id in (?) and created_at >= ?", a, Time.now.beginning_of_day).order(id: :desc).first
    if d.present? && d.number.present?
      n = d.number.split('-')[2].to_i + 1
    else
      n = 1
    end
    s = "%05d" % n
    s_number = "#{t}-#{Time.now.strftime('%Y%m%d')}-#{s}"
  end
end
