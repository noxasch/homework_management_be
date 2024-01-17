class Api::V1::Teachers::Homeworks::Update < ApplicationMutation
  required do
    model :current_user, class: ::User
    integer :id
  end

  optional do
    integer :subject_id
    time :due_at
    string :title
  end

  protected

  def execute
    homework.save! && homework.reload
  end

  def validate
    true
  end

  def homework
    return @homework if @homework

    @homework = current_user.homeworks.find(id)
    @homework.assign_attributes(params)
    @homework
  end

  def params
    inputs.slice(
      :subject_id,
      :title,
      :due_at
    ).compact
  end
end
