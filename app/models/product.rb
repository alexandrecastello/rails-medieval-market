class Product < ApplicationRecord
  belongs_to :user_id
  has_many :orders
  has_many :users, through :orders
end
