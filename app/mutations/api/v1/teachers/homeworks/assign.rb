class Api::V1::Teachers::Homeworks::Assign < ApplicationMutation
  required do
    model :current_user, class: ::User
    integer :id
    integer :student_id
  end

  protected

  def execute
    assigned_homeworks.save! && homework.reload
  end

  def validate; end

  private

  def assigned_homeworks
    return @assigned_homeworks if @assigned_homeworks

    @assigned_homeworks = homework.assigned_homeworks.new
    @assigned_homeworks.assign_attributes(params)
    @assigned_homeworks
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
