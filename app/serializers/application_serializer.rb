class ApplicationSerializer < ActiveModel::Serializer
  def datetime_formatted(time)
    time.strftime('%d-%m-%Y')
  end
end
