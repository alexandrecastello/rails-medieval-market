class User < ApplicationRecord
  has_many :products  # precisa? confirmar com algum TA/prof
  has_many :orders
  has_many :products, through: :orders
  # has_one_attached :avatar #testar se :avatar funciona, se não usar :photo
  
  # validates
end
