class Product < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  has_many :orders
  has_many :buyers, through: :orders, source: :user

  include PgSearch::Model
  pg_search_scope :global_search,
    against: [:name, :description],
    using: {
      tsearch: {prefix: true}
    }

end
