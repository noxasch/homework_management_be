class Api::V1::Teachers::Homeworks::Create < ApplicationMutation
  required do
    model :current_user, class: ::User
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

  private

  def homework
    return @homework if @homework

    @homework = current_user.homeworks.new
    @homework.assign_attributes(params)
    @homework
  end

  def params
    {
      subject_id:,
      title:,
      due_at:
    }
  end
end
