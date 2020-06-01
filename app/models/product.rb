class Product < ApplicationRecord
  belongs_to :owner, source: :user
  has_many :orders
  has_many :buyers, through: :orders, source: :user
end
