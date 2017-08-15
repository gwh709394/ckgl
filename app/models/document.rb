class Document < ApplicationRecord
  belongs_to :staff
  belongs_to :warehouse
  has_many :stocks
end
