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
    puts "Tworzenie wiadomości"
    40.times do |n|
      m = Message.create!(title: "Hej ##{n + 1}", sender_id: 2, body: "Treść")
      m.sendings.create!(user_id: 1)
      m = Message.create!(title: "Cześć ##{n+1}", sender_id: 1, body: "Treść")
      m.sendings.create!(user_id: 2)
    end
    puts "Tworzenie kursów"
    40.times do |n|
      c = Course.create!(name: "Kurs #{n+1}", description: "Lerom ipsum")
      30.times do |i|
        lc = c.lesson_categories.create!(name: "Kategoria #{i + 1}",
                                         flagged: i % 15 == 0 ? true : false)
        5.times do |x|
          lc.lessons.create!(name: "Lekcja ##{x}")
        end
      end
      c.attendings.create!(user_id: 1, role_id: 1)
      c.attendings.create!(user_id: 2, role_id: 2) if n < 5
    end
    puts "Dane do logowania: "
    puts "email: #{user_email}"
    puts "hasło: #{user_password}"
  end
end
