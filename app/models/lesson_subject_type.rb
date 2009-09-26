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
    unless self.homepage.nil? or self.homepage.empty?
      if self.homepage.starts_with? "http://"
        if self.homepage == "http://"
          self.homepage = ""
        end
      else
        self.homepage = "http://" + self.homepage
      end
    end
  end
end
