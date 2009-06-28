class CreateLessons < ActiveRecord::Migration
  def self.up
    create_table :lessons do |t|
      t.integer :group_id
      t.integer :lesson_subject_type_id
      t.integer :term
      t.integer :day_of_week
      t.time :start_time
      t.integer :duration
      t.boolean :everyweek
      t.boolean :odd_weeks

      t.timestamps
    end
  end

  def self.down
    drop_table :lessons
  end
end
