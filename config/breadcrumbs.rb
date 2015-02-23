crumb :root do
  link 'Strona główna', root_path
end

#
# Courses
#

crumb :courses do
  link 'Kursy', courses_path
end

crumb :new_course do
  link "Nowy kurs", new_course_path
  parent :courses
end

crumb :course do |course|
  link course.name, course_path(course)
  parent :courses
end

crumb :course_settings do |course|
  link 'Ustawienia', settings_course_path(course)
  parent :course, course
end

#
# Lessons
#

crumb :new_lesson do |course|
  link 'Nowa lekcja', new_course_lesson_path(course)
  parent :course, course
end

crumb :lesson do |lesson, course|
  link lesson.name, course_lesson_path(course, lesson)
  parent :course, course
end

crumb :edit_lesson do |lesson, course|
  link "Edytuj #{ lesson.name }", edit_course_lesson_path(course, lesson)
  parent :course, course
end


#
# Material Categories
#

crumb :new_material_category do |course|
  link 'Nowy zestaw materiałów', new_course_lesson_path(course)
  parent :course, course
end

crumb :material_category do |m_c, course|
  link m_c.name, course_material_category_path(course, m_c)
  parent :course, course
end

#
# Exams
#

crumb :new_exam do |course|
  link "Nowy egzamin", new_course_exam_path(course)
  parent :course, course
end

crumb :edit_exam do |exam, course|
  link "Edytuj #{exam}", edit_course_exam_path(course, exam)
  parent :course, course
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

crumb :edit_user do |user|
  link "Edycja profilu", edit_user_path(user)
  parent :user, user
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
