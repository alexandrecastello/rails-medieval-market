class User < ApplicationRecord
  has_many :owned_products, source: :products 
  has_many :orders
  has_many :bought_products, through: :orders, source: :products
  # has_one_attached :avatar #testar se :avatar funciona, se não usar :photo
  
  # validates
end
