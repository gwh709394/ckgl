class Document < ApplicationRecord
  belongs_to :staff
  belongs_to :warehouse
  has_many :stocks, dependent: :destroy
  paginates_per 15
end
