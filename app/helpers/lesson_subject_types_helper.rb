module LessonSubjectTypesHelper
  def link_to_subject_type(subject_type, *fields)
    return nil if subject_type.nil?
    # only :subject, :group, :lesson_type or :teacher fields are allowed:
    fields.delete_if {|field| not [:subject, :group, :lesson_type, :teacher].include? field}
    # create text string:
    text = fields.empty? ? "Тип занятия №#{subject_type.id}" : fields.map {|field| h( subject_type.send(field).name ) }.join(", ")
    link_to text, lesson_subject_type_path(subject_type)
  end
end
