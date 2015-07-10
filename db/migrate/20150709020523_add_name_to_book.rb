class AddNameToBook < ActiveRecord::Migration
  def change
    add_column :books, :name, :string
  end
end
