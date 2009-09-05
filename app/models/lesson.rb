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

  BEGIN_TIME_OBJ = Time.utc(* DEFAULT_DATE+BEGIN_TIME)
  END_TIME_OBJ = Time.utc(* DEFAULT_DATE+END_TIME)

  SECONDS_PER_PIXEL = 50 # scale for drawing lessons

  validates_inclusion_of  :start_time,
                          :in => BEGIN_TIME_OBJ..END_TIME_OBJ,
                          :message => "должно быть от #{BEGIN_TIME[0]} до #{END_TIME[0]} часов",
                          :allow_nil => true

  validates_each( :duration ) do |model, attr, value|
    unless  model.start_time.nil? or
            model.duration.nil? or
            model.start_time + value <= END_TIME_OBJ
      model.errors.add(attr, "должна быть такой, чтобы занятие заканчивалось раньше #{END_TIME[0]} часов" )
    end
  end

  def validate
    that_day_lessons = Lesson.lessons_for self.group, self.term, self.day_of_week

    crossing_lesson = nil
    that_day_lessons.each do |lesson|
      if  (lesson.id != self.id) and
          ((lesson.end_time > self.start_time and lesson.end_time <= self.end_time) or
           (lesson.start_time >= self.start_time and lesson.start_time < self.end_time) or
           (lesson.start_time <= self.start_time and lesson.end_time >= self.end_time))
        crossing_lesson = lesson
        break
      end
    end
    errors.add_to_base( "Время с " +
                        crossing_lesson.start_time.strftime("%H:%M") +
                        " по " +
                       crossing_lesson.end_time.strftime("%H:%M") +
                        " уже занято другим занятием" ) if crossing_lesson
  end
  
  belongs_to  :group
  belongs_to  :subject_type,
              :class_name => "LessonSubjectType",
              :foreign_key => "lesson_subject_type_id"
  
  attr_accessor :lesson_subject_id
  attr_accessor :lesson_type_id

  STANDARD_INTERVALS = (0..6).map do |i|
    start = Time.utc(* DEFAULT_DATE + [9, 0]) + i*(1.hour + 45.minutes)
    { :start => start,
      :end => start + 1.hour + 35.minutes }
  end

  def set_start_time(hours, mins = 0)
    self.start_time = Time.utc(*DEFAULT_DATE + [hours, mins])
  end

  def duration_hour
    self.duration/3600
  end
  def duration_min
    self.duration%3600/60
  end

  def end_time
    self.start_time + self.duration
  end

  def Lesson.lessons_for(group, term, day_of_week)
    find_all_by_group_id_and_term_and_day_of_week( group, term, day_of_week, :order => "start_time" )
    #TODO: not-everyweek lessons support
  end
end
