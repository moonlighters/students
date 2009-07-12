class CreateLessonTypes < ActiveRecord::Migration
  def self.up
    create_table :lesson_types do |t|
      t.string :name

      t.timestamps
    end

    LessonType.create :name => "лекция"
    LessonType.create :name => "семинар"
    LessonType.create :name => "сдача"
    LessonType.create :name => "практика"
    LessonType.create :name => "консультация"
  end

  def self.down
    drop_table :lesson_types
  end
end
