class AddReceptionWeightFinishedToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :reception_date, :date
    add_column :orders, :weight, :float
    add_column :orders, :finished, :string
  end
end
