class LessonSubjectType < ActiveRecord::Base
  validates_presence_of :lesson_type_id, :lesson_subject_id, :group_id, :teacher_id
  before_save :process_homepage_url

  belongs_to :lesson_type
  
  belongs_to :subject,
             :class_name => "LessonSubject",
             :foreign_key => "lesson_subject_id"
  
  belongs_to :group
  belongs_to :teacher

  has_many  :lessons,
            :dependent => :destroy

  def process_homepage_url
    /(http:\/\/)?(.+)?/ =~ self.homepage
    self.homepage = ($2) ? ("http://" + $2) : ""
  end
end
