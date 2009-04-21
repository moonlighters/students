class CreateTeachers < ActiveRecord::Migration
  def self.up
    create_table :teachers do |t|
      t.string :name
      t.string :surname
      t.string :phone
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :teachers
  end
end
