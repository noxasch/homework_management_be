# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# if Doorkeeper::Application.count.zero?
#   app = Doorkeeper::Application.create(
#     name: 'Vue client',
#     redirect_uri: 'urn:ietf:wg:oauth:2.0:oob',
#     scopes: %w[read write],
#     confidential: false
#   )
#   Rails.logger.info("CLIENT_ID: #{app.uid}")
# end

if Subject.count.zero?
  Subject.create!(
    color: '#ff3333',
    name: 'Mathematics'
  )
  Subject.create!(
    color: '#3333ff',
    name: 'English'
  )
  Subject.create!(
    color: '#4ca64c',
    name: 'Physics'
  )
end

if User.teacher.count.zero?
  User.create!(
    name: 'Teacher',
    email: 'teacher@example.com',
    password: 'password',
    role: :teacher
  )
end

if User.student.count.zero?
  User.create!(
    name: 'Student 1',
    email: 'student@example.com',
    password: 'password',
    role: :student
  )
end
