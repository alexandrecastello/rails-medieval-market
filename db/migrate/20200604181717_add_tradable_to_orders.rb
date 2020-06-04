class AddTradableToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :tradable, :string
  end
end
