class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.integer :annual_salary
      t.string :super_rate
      t.string :payment_start_date
      t.integer :gross_income
      t.integer :income_tax
      t.integer :net_income
      t.integer :super

      t.timestamps
    end
  end
end
