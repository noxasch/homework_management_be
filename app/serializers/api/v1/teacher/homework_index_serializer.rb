class Api::V1::Teacher::HomeworkIndexSerializer < ApplicationSerializer
  attributes :id, :title, :subject, :due_date, :submitted, :total, :color

  def subject
    object.subject.name
  end

  def color
    object.subject.color
  end

  def due_date
    datetime_formatted(object.due_at)
  end

  def submitted
    object.assigned_homeworks.where(status: :completed).count
  end

  def total
    object.assigned_homeworks.count
  end
end
