require "csv"

User.create!(name:  "kamada.engineer",
             email: "kamada.engineer@gmail.com",
             password:              "password",
             password_confirmation: "password",
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

#movieをcsv経由で追加する
CSV.foreach('db/movies.csv', headers: true) do |row|
  Movie.create(
    title: row['title'],
    release: row['release'],
    production: row['production'],
    screening_time: row['screening_time'],
    genre: row['genre'],
    status: row['status']
  )
end

#castをcsv経由で追加する
CSV.foreach('db/casts.csv', headers: true) do |row|
  Cast.create(
    name: row['name'],
    country: row['country'],
    hometown: row['hometown']
  )
end

#movie_castをcsv経由で追加する
CSV.foreach('db/movie_casts.csv', headers: true) do |row|
  MovieCast.create(
    relation: row['relation'],
    movie_id: row['movie_id'],
    cast_id: row['cast_id']
  )
end

#dramaをcsv経由で追加する
CSV.foreach('db/dramas.csv', headers: true) do |row|
  Drama.create(
    title: row['title'],
    release: row['release'],
    production: row['production'],
    genre: row['genre'],
    status: row['status']
  )
end

#drama_castをcsv経由で追加する
CSV.foreach('db/drama_casts.csv', headers: true) do |row|
  DramaCast.create(
    relation: row['relation'],
    drama_id: row['drama_id'],
    cast_id: row['cast_id']
  )
end


# リレーションシップ
users = User.all
users.each do |user|
  r = rand(101)
  following = users[0..101].sample(r)
  following.each do |followed|
    unless user.id == followed.id
      user.follow(followed)
    end
  end
end