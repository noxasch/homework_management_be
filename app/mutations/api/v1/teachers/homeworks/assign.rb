class Api::V1::Teachers::Homeworks::Assign < ApplicationMutation
  required do
    model :current_user, class: ::User
    integer :id
    integer :student_id
  end

  protected

  def execute
    student_homeworks.save! && homework.reload
  end

  def validate; end

  private

  def student_homeworks
    return @student_homeworks if @student_homeworks

    @student_homeworks = homework.student_homeworks.new
    @student_homeworks.assign_attributes(params)
    @student_homeworks
  end

  def homework
    @homework ||= current_user.homeworks.find(id)
  end

  def params
    inputs.slice(
      :student_id
    )
  end
end
