class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.datetime :rental_date
      t.datetime :return_date
      t.integer :book_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
