module TeachersHelper
  def link_to_teacher(teacher, options = {})
    return nil if teacher.nil?
    link_to h( teacher.name+" "+teacher.surname ), teacher_path( teacher ), options
  end
end
