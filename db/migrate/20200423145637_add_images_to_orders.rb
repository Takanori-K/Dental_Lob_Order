class AddImagesToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :image_1, :string
    add_column :orders, :image_2, :string
    add_column :orders, :image_3, :string
  end
end
