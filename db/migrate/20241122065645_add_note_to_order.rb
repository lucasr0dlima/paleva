class AddNoteToOrder < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :note, :string
  end
end