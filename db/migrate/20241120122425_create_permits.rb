class CreatePermits < ActiveRecord::Migration[7.2]
  def change
    create_table :permits do |t|
      t.string :email
      t.string :cpf
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
