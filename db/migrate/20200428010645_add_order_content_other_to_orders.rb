class AddOrderContentOtherToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :content_other, :string
  end
end
