class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :owned_products, source: :products
  has_many :orders
  has_many :bought_products, through: :orders, source: :products
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
