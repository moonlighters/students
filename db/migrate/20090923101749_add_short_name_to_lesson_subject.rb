class AddShortNameToLessonSubject < ActiveRecord::Migration
  def self.up
    add_column :lesson_subjects, :short_name, :string
  end

  def self.down
    remove_column :lesson_subjects, :short_name
  end
end
