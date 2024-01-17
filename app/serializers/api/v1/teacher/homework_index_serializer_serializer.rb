class Api::V1::Teacher::HomeworkIndexSerializerSerializer < ApplicationSerializer
  attributes :id, :title, :subject, :due_date, :submitted, :total

  def subject
    object.subject.name
  end

  def due_date
    datetime_formatted(object.due_at)
  end

  def submitted
    object.student_homeworks.where(status: :completed).count
  end

  def total
    object.student_homeworks.count
  end
end
