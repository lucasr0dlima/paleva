class AddAttributesToBeverages < ActiveRecord::Migration[7.2]
  def change
    add_reference :beverages, :user, null: false, foreign_key: true
    add_reference :beverages, :restaurant, null: false, foreign_key: true
  end
end
