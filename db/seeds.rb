require "csv"

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

#actorをcsv経由で追加する
CSV.foreach('db/actors.csv', headers: true) do |row|
  Actor.create(
    name: row['name'],
    country: row['country'],
    hometown: row['hometown']
  )
end

#movieをcsv経由で追加する
CSV.foreach('db/movies.csv', headers: true) do |row|
  Movie.create(
    title: row['title'],
    release: row['release'],
    production: row['production'],
    screening_time: row['screening_time'],
    genre: row['genre'],
    status: row['status'],
  )
end

#movie_actorをcsv経由で追加する
CSV.foreach('db/movie_actors.csv', headers: true) do |row|
  MovieActor.create(
    movie_id: row['movie_id'],
    actor_id: row['actor_id'],
  )
end

#directorをcsv経由で追加する
CSV.foreach('db/directors.csv', headers: true) do |row|
  Director.create(
    name: row['name'],
    country: row['country'],
    hometown: row['hometown']
  )
end

#writerをcsv経由で追加する
CSV.foreach('db/writers.csv', headers: true) do |row|
  Writer.create(
    name: row['name'],
    country: row['country'],
    hometown: row['hometown']
  )
end

#movie_directorをcsv経由で追加する
CSV.foreach('db/movie_directors.csv', headers: true) do |row|
  MovieDirector.create(
    movie_id: row['movie_id'],
    director_id: row['director_id'],
  )
end

#movie_writerをcsv経由で追加する
CSV.foreach('db/movie_writers.csv', headers: true) do |row|
  MovieWriter.create(
    movie_id: row['movie_id'],
    writer_id: row['writer_id'],
  )
end