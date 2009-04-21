class CreateLessonSubjects < ActiveRecord::Migration
  def self.up
    create_table :lesson_subjects do |t|
      t.string :name
      t.integer :term

      t.timestamps
    end
  end

  def self.down
    drop_table :lesson_subjects
  end
end
