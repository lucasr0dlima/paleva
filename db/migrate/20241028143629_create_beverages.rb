class CreateBeverages < ActiveRecord::Migration[7.2]
  def change
    create_table :beverages do |t|
      t.string :name
      t.string :description
      t.boolean :alcohol
      t.string :calories
      t.string :image

      t.timestamps
    end
  end
end
