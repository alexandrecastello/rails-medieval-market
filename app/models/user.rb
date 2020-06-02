class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :owned_products, class_name: 'Product', foreign_key: 'product_id', dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :bought_products, through: :orders, source: :products
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
