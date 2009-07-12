class CreateLessonSubjectTypes < ActiveRecord::Migration
  def self.up
    create_table :lesson_subject_types do |t|
      t.integer :lesson_type_id
      t.integer :lesson_subject_id
      t.integer :group_id
      t.integer :teacher_id
      t.string :homepage

      t.timestamps
    end
  end

  def self.down
    drop_table :lesson_subject_types
  end
end
