class ChangeColumnInPortions < ActiveRecord::Migration[7.2]
  def change
    change_column :portions, :price, :integer
  end
end
