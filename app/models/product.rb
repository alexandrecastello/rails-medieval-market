class Product < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  has_many :orders
  has_many :buyers, through: :orders, source: :user
  validates_presence_of :name, on: :create, message: "can't be blank"
  validates :coin_price, on: :create, presence: true, numericality: { other_than: 0, message: "can't be zero" } 
  validates :quantity, on: :create, presence: true, numericality: { other_than: 0, message: "can't be zero" }
  
  has_one_attached :photo


  include PgSearch::Model
  pg_search_scope :global_search,
    against: [:name, :description],
    using: {
      tsearch: {prefix: true}
    }

end
