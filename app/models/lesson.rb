class Lesson < ActiveRecord::Base
  # -------------------------------
  #           Constants
  # -------------------------------
  DEFAULT_DATE = [1970, "jan", 1]  # the same date will be set to Time object to store it in the DB as datetime
  BEGIN_TIME = [9, 0]
  END_TIME = [22, 0]

  START_DATES = [ [2, 9], [9, 1] ] # 9'th February for even terms, 1'st September for odd ones
                                   # (for odd_week? and term functions)

  BEGIN_TIME_OBJ = Time.utc(* DEFAULT_DATE+BEGIN_TIME)
  END_TIME_OBJ = Time.utc(* DEFAULT_DATE+END_TIME)

  SECONDS_PER_PIXEL = 100.0 # scale for drawing lessons

  # INTERVALS array generation
  DURATION = 1.hour + 35.minutes
  BREAK_DURATION = 10.minutes
  INTERVALS = (0..6).map do |i|
    start_time = Time.utc(* DEFAULT_DATE + [9, 0]) + i*(DURATION + BREAK_DURATION)
    
    Lesson.new :start_time => start_time, :duration => DURATION
  end
  # -------------------------------
  #          Validations
  # -------------------------------
  validates_presence_of :group_id,
                        :term,
                        :day_of_week,
                        :start_time
  validates_presence_of :duration,
                        :room,
                        :message => "должна быть указана"

  validates_presence_of :lesson_subject_type_id,
                        :message => " с такими значениями полей Предмет, Тип, Группа не найден. "

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
    odd_week = self.everyweek? ? :both : self.odd_weeks?
    that_day_lessons = Lesson.lessons_for( self.group, self.term, self.day_of_week, odd_week ) || []

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
  # -------------------------------
  #         Attributes 
  # -------------------------------
  belongs_to  :group
  belongs_to  :subject_type,
              :class_name => "LessonSubjectType",
              :foreign_key => "lesson_subject_type_id"
  
  attr_accessor :lesson_subject_id
  attr_accessor :lesson_type_id

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

  def subject
    self.subject_type.subject if self.subject_type
  end

  def type
    self.subject_type.lesson_type if self.subject_type
  end
  # -------------------------------
  #         Class methods
  # -------------------------------
  def Lesson.lessons_for(group, term, day_of_week, odd_week = :both)
    # Check if there is any schedule for given group and term
    return [] if term == NO_TERM_VACATION or term == NO_TERM_EXAMINATIONS
    return nil if find_by_group_id_and_term( group, term ).nil?

    # Otherwise - just find lessons for :both odd and even weeks, or for requested week only
    if odd_week == :both
      find_all_by_group_id_and_term_and_day_of_week( group, term, day_of_week, :order => "start_time" )
    else
      # TODO: How to search for boolean attributes without this {:true => true} ???
      find  :all,
            :conditions => [ "group_id = :group AND term = :term AND day_of_week = :day_of_week AND (everyweek = :true OR everyweek = :false AND odd_weeks = :odd_week)",
                             { :group => group, :term => term, :day_of_week => day_of_week, :odd_week => odd_week, :true => true, :false => false } ],
            :order => "start_time"
    end
  end

  NO_TERM_VACATION = 0
  NO_TERM_EXAMINATIONS = -1
  def Lesson.term(date, start_year)
    raise ArgumentError, "given date is earlier then studying start date" if date.year < start_year or
                                                                            (date.year == start_year and date.month <= 8)
    if date.month == 1 or (date.month == 2 and date.day < START_DATES.first[1])
      NO_TERM_EXAMINATIONS            # January - examinations
    elsif date.month <= 5
      (date.year - start_year)*2      # February to May - 2, 4, 6, ...
    elsif date.month == 6
      NO_TERM_EXAMINATIONS            # June - examinations
    elsif date.month >= 9
      (date.year - start_year)*2 + 1  # September to December - 1, 3, 5, ...
    else
      NO_TERM_VACATION                # July to August - summer vacation
    end
  end

  def Lesson.odd_week?(date)
    today = Date.new date.year, date.month, date.day

    term_starts = (0..1).map do |i|
      date = Date.new( * [today.year] + Lesson::START_DATES[i] ) 
      date += 1 if date.cwday == 7
      date
    end

    term =  (today > term_starts[0] and today < term_starts[1]) ? 0 : 1
    
    (today.cweek - term_starts[term].cweek + 1) % 2 == 1
  end
end
