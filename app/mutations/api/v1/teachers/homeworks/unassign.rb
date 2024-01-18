class Api::V1::Teachers::Homeworks::Unassign < ApplicationMutation
  required do
    model :current_user, class: ::User
    integer :id
    integer :student_id
  end

  protected

  def execute
    assigned_homeworks.destroy! && true
  end

  private

  def assigned_homeworks
    @assigned_homeworks ||= homework.assigned_homeworks.find_by(student_id:)
  end

  def homework
    @homework ||= current_user.homeworks.find(id)
  end
end
