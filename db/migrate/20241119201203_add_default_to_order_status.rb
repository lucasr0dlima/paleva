class AddDefaultToOrderStatus < ActiveRecord::Migration[7.2]
  def change
    change_column_default :orders, :status, from: nil, to: 0
  end
end
