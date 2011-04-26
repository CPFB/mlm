class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|
      t.references :student
      t.references :instructor
      t.date :date
      t.decimal :amount, :precision => 8, :scale => 2
      t.string :payment_type
      t.string :check_number
      t.text :notes
      t.decimal :balance, :precision => 8, :scale => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :payments
  end
end
