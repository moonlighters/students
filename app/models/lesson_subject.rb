class LessonSubject < ActiveRecord::Base
  validates_presence_of :name, :term
  validates_each :term do |model, attr, value|
    if value and value <= 0
      model.errors.add(attr, "должен быть числом больше 0")
    end
  end

  def types_in_group(group)
    subject_types_in_group( group ).map {|st| st.lesson_type}
  end

  def subject_types_in_group(group)
    LessonSubjectType.find_all_by_lesson_subject_id_and_group_id self.id, group.id
  end
end
