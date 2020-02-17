User.create!(name:  "kamada.engineer",
             email: "kamada.engineer@gmail.com",
             password:              "moto0726",
             password_confirmation: "moto0726",
             nickname: "kamada",
             agreement: true,
             activated: true,
             activated_at: Time.zone.now,
             admin: true)
User.create!(name:  "example",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             nickname: "Example User",
             agreement: true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = "example-#{n+1}"
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  nickname = Faker::Name.name
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               nickname: nickname,
               agreement: true,
               activated: true,
               activated_at: Time.zone.now)

end