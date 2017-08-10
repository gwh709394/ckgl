class StockingType
  RECEVING = 1
  SHIPPING = 2

  
  def self.display state
    case state
      when RECEVING
        '入库'
      when SHIPPING
        '出库'
      else
        '未知状态'
    end
  end
  
  def self.menu
    data = []
    self.constants.each do |c|
      v = self.const_get(c)
      data << [self.display(v), v]
    end
    data
  end
end