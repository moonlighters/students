class Lesson < ActiveRecord::Base
  validates_presence_of :group_id,
                        :lesson_subject_type_id,
                        :term,
                        :day_of_week,
                        :start_time,
                        :duration

  before_validation :set_term

  belongs_to  :group
  belongs_to  :subject_type,
              :class_name => "LessonSubjectType",
              :foreign_key => "lesson_subject_type_id"

  def set_term
    unless self.subject_type.nil?
      self.term = self.subject_type.subject.term
    end
  end

  def set_start_time(hours, mins)
    self.start_time = Time.mktime(1970, "jan", 1, hours, mins);
  end
end
