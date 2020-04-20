class AddTryCompleteToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :first_try, :datetime
    add_column :orders, :second_try, :datetime
    add_column :orders, :complete_day, :datetime
  end
end
