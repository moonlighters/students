module LessonSubjectTypesHelper
  include TeachersHelper

  def simple_link_to_subject_type(subject_type, content)
      link_to content, lesson_subject_type_path(subject_type)
  end

  def link_to_subject_type(subject_type, comma_separated, *fields)
    return nil if subject_type.nil?
    # only :subject, :group, :lesson_type or :teacher fields are allowed:
    fields.delete_if { |field| not [:subject, :group, :lesson_type, :teacher].include? field }
    
    if fields.empty?
      simple_link_to_subject_type subject_type, "Тип занятия №#{subject_type.id}"
    elsif comma_separated
      # if comma-separated format selected the result is a single link to subject_type
      # containing given fields separated by commas
      text = fields.map {|field| h( subject_type.send(field).name ) }.join(", ")
      simple_link_to_subject_type subject_type, text
    else
      # if not comma-separated format selected, all fields displayed are links,
      # and the link containing field :lesson_type is a link to subject_type itself
      fields.map do |field|
        case field
        when :subject
          "по " + link_to( h( subject_type.subject.short_name ), lesson_subject_path( subject_type.subject ) )
        when :group
          "в " + link_to( "группе " + h( subject_type.group.name ), group_path( subject_type.group ) )
        when :lesson_type
          simple_link_to_subject_type subject_type, h( subject_type.lesson_type.name )
        when :teacher
          "ведёт " + link_to_teacher( subject_type.teacher )
        else
          raise "Illegal field left after check, it's a bug!"
        end
      end.join(" ")
    end
  end
end
