class Lesson < ActiveRecord::Base
  validates_presence_of :group_id,
                        :term,
                        :day_of_week,
                        :start_time,
                        :duration

  validates_presence_of :lesson_subject_type_id,
                        :message => " с такими значениями полей Предмет, Тип, Группа не найден. "

  DEFAULT_DATE = [1970, "jan", 1]
  BEGIN_TIME = [9, 0]
  END_TIME = [22, 0]

  validates_inclusion_of  :start_time,
                          :in => Time.mktime(* DEFAULT_DATE+BEGIN_TIME)..Time.mktime(* DEFAULT_DATE+END_TIME),
                          :message => "должно быть от #{BEGIN_TIME[0]} до #{END_TIME[0]} часов",
                          :allow_nil => true

  validates_each( :duration ) do |model, attr, value|
    unless  model.start_time.nil? or
            model.duration.nil? or
            model.start_time + value <= Time.mktime(* DEFAULT_DATE+END_TIME)
      model.errors.add(attr, "должна быть такой, чтобы занятие заканчивалось раньше #{END_TIME[0]} часов" )
    end
  end
                          
  
  belongs_to  :group
  belongs_to  :subject_type,
              :class_name => "LessonSubjectType",
              :foreign_key => "lesson_subject_type_id"
  
  attr_accessor :lesson_subject_id
  attr_accessor :lesson_type_id

  def set_start_time(hours, mins = 0)
    self.start_time = Time.mktime(*DEFAULT_DATE + [hours, mins]);
  end

  def duration_hour
    self.duration/3600
  end
  def duration_min
    self.duration%3600/60
  end

  WDAYS = %w{Воскресенье Понедельник Вторник Среда Четверг Пятница Суббота}
end
