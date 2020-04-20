class AddContentCrownMetalToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :content, :string
    add_column :orders, :crown, :string
    add_column :orders, :metal, :string
  end
end
