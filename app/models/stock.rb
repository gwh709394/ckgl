class Stock < ApplicationRecord
  belongs_to :warehouse
  belongs_to :stock_type
end
