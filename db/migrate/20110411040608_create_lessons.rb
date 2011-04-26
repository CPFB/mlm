class CreateLessons < ActiveRecord::Migration
  def self.up
    create_table :lessons do |t|
      t.references :student
      t.references :instructor
      t.datetime :datetime
      t.decimal :charge, :precision => 8, :scale => 2
      t.text :notes
      t.decimal :balance, :precision => 8, :scale => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :lessons
  end
end
