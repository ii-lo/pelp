namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    user_name = "jajakobyly"
    user_password = "jajakobyly"
    user_email = "jajakobyly@jajakobyly.com"
    Rake::Task["db:schema:load"].execute
    puts "Tworzenie użytkowników"
    User.create!(name: user_name, email: user_email,
                 password: user_password, password_confirmation: user_password)
    User.create!(name: "Robert Białas", email: "r@r.com", password: "robert",
                 password_confirmation: "robert")
    puts "Tworzenie kursów"
    40.times do |n|
      c = Course.create!(name: "Kurs #{n+1}", description: "Lerom ipsum")
      (rand(9) + 1).times do |i|
        lc = c.lesson_categories.create!(name: "Kategoria #{i + 1}",
                                         flagged: i % 15 == 0 ? true : false)
        (rand(5) + 1).times do |x|
          lc.lessons.create!(name: "Lekcja ##{x}")
        end
      end
      c.attendings.create!(user_id: 1, role_id: 1)
      c.attendings.create!(user_id: 2, role_id: 2) if n < 5
    end
    puts "Tworzę egzamin"
    Exam.create(lesson_category_id: 1, duration: 2700, name: "Przykładowy sprawdzian")
    QuestionCategory.create(name: "Ogólne")
    Question.create(name: "Czy ziemia jest płaska?",
                    value: 2, exam_id: 1, question_category_id: 1)
    Answer.create(name: "Tak", correct: false, question_id: 1)
    Answer.create(name: "Nie", correct: true, question_id: 1)
    Question.create(name: "Jakie programy domyślnie ma Łubuntu?",
                    value: 2, form: 1, exam_id: 1, question_category_id: 1)
    Answer.create(name: "Firefox", correct: true, question_id: 2)
    Answer.create(name: "Google Chrome", correct: false, question_id: 2)
    Answer.create(name: "LibreOffice Writer", correct: true, question_id: 2)
    Answer.create(name: "Microsoft Office Word", correct: false, question_id: 2)
    Question.create(name: "Jakiego koloru jest krew ludzka?",
                    form: 2, value: 2, exam_id: 1, question_category_id: 1)
    Answer.create(name: "Czerwonego", question_id: 3)
    Answer.create(name: "Czerwony", question_id: 3)

    Attending.first.update_last_visit

    puts "Dane do logowania: "
    puts "email: #{user_email}"
    puts "hasło: #{user_password}"
  end
end
