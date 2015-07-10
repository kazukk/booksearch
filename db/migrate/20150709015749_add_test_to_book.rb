class AddTestToBook < ActiveRecord::Migration
  def change
    add_column :books, :test, :string
  end
end
