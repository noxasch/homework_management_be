class Api::V1::Student::HomeworkIndexSerializer < ApplicationSerializer
  attributes :id, :title, :subject, :due_date, :status

  def homework
    @homework ||= object.homework
  end

  delegate :title, to: :homework

  def subject
    homework.subject.name
  end

  def due_date
    datetime_formatted(homework.due_at)
  end
end
