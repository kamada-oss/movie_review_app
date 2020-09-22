# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20200922115740) do

  create_table "books", force: :cascade do |t|
    t.integer "user_id"
    t.integer "movie_id"
    t.integer "drama_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["drama_id"], name: "index_books_on_drama_id"
    t.index ["movie_id"], name: "index_books_on_movie_id"
    t.index ["user_id", "created_at"], name: "index_books_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_books_on_user_id"
  end

  create_table "casts", force: :cascade do |t|
    t.string "name"
    t.string "country"
    t.string "hometown"
    t.string "picture"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "drama_casts", force: :cascade do |t|
    t.string "relation"
    t.integer "drama_id"
    t.integer "cast_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cast_id"], name: "index_drama_casts_on_cast_id"
    t.index ["drama_id"], name: "index_drama_casts_on_drama_id"
  end

  create_table "dramas", force: :cascade do |t|
    t.string "title"
    t.date "release"
    t.string "production"
    t.string "genre"
    t.string "status"
    t.string "picture"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "cast_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cast_id"], name: "index_likes_on_cast_id"
    t.index ["user_id", "created_at"], name: "index_likes_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "movie_casts", force: :cascade do |t|
    t.string "relation"
    t.integer "movie_id"
    t.integer "cast_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cast_id"], name: "index_movie_casts_on_cast_id"
    t.index ["movie_id"], name: "index_movie_casts_on_movie_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.date "release"
    t.string "production"
    t.integer "screening_time"
    t.string "genre"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.float "star"
    t.text "comment"
    t.integer "user_id"
    t.integer "movie_id"
    t.integer "drama_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["drama_id"], name: "index_reviews_on_drama_id"
    t.index ["movie_id"], name: "index_reviews_on_movie_id"
    t.index ["user_id", "created_at"], name: "index_reviews_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "nickname"
    t.boolean "agreement", default: false
    t.string "remember_digest"
    t.string "profile"
    t.boolean "admin", default: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.string "picture"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
  end

end
