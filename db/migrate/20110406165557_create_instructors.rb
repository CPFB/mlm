class CreateInstructors < ActiveRecord::Migration
  def self.up
    create_table :instructors do |t|
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :instructors
  end
end
