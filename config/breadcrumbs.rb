crumb :root do
  link 'Strona główna', root_path
end

#
# Courses
#

crumb :courses do
  link 'Kursy', courses_path
end

crumb :course do |course|
  link course.name, course_path(course)
  parent :courses
end

crumb :course_settings do |course|
  link 'Ustawienia', settings_course_path(course)
  parent :course
end

#
# Users
#

crumb :users do
  link 'Użytkownicy', root_path # TODO point to users search page here
end

crumb :user do |user|
  link user.name, user_path(user)
  parent :users
end

#
# Miscellaneous
#

crumb :help do
  link 'Pomoc', help_path
end

crumb :privacy do
  link 'Polityka prywatności', privacy_path
  parent :help
end

crumb :rules do
  link 'Regulamin', rules_path
  parent :help
end
