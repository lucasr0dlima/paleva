class AddStatusToProduct < ActiveRecord::Migration[7.2]
  def change
    add_column :products, :status, :integer, default: 0
  end
end
