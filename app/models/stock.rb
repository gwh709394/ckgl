class Stock < ApplicationRecord
  belongs_to :document
  belongs_to :commodity
end
