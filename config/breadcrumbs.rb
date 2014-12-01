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

crumb :course_grades do |course|
  link 'Oceny', grades_course_path(course)
  parent course
end

crumb :course_activity do |course|
  link 'Aktywność', activity_course_path(course)
  parent course
end

crumb :course_info do |course|
  link 'Informacje', info_course_path(course)
  parent course
end

crumb :course_settings do |course|
  link 'Ustawienia', settings_course_path(course)
  parent course
end

#
# Users
#

crumb :user do |user|
  link user.name, user_path(user)
end

#
# Miscellaneous
#

crumb :help do
  link 'Pomoc', help_path
end

crumb :privacy do
  link 'Polityka prywatności', privacy_path
end

crumb :rules do
  link 'Regulamin', rules_path
end