class Api::V1::Teachers::Homeworks::Destroy < ApplicationMutation
  required do
    model :current_user, class: ::User
    integer :id
  end

  protected

  def execute
    homework.destroy! && true
  end

  def homework
    @homework ||= current_user.homeworks.find_by(id:)
  end
end
