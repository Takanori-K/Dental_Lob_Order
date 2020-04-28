class AddOrderOtherTextToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :other_text, :string
  end
end
