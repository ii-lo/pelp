# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150214201905) do

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "answers", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.boolean  "correct",                 default: false
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id"

  create_table "attendings", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_visit"
    t.integer  "role",       default: 0
  end

  add_index "attendings", ["course_id"], name: "index_attendings_on_course_id"
  add_index "attendings", ["user_id"], name: "index_attendings_on_user_id"

  create_table "category_results", force: :cascade do |t|
    t.integer  "user_exam_id"
    t.integer  "question_category_id"
    t.decimal  "value",                default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "category_results", ["question_category_id"], name: "index_category_results_on_question_category_id"
  add_index "category_results", ["user_exam_id"], name: "index_category_results_on_user_exam_id"

  create_table "courses", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description", limit: 255
    t.boolean  "private",                 default: false
    t.string   "header",      limit: 255
    t.string   "thumb",       limit: 255
    t.string   "password",                default: ""
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",               default: 0, null: false
    t.integer  "attempts",               default: 0, null: false
    t.text     "handler",                            null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "exams", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lesson_category_id"
    t.integer  "duration"
    t.integer  "max_points",                     default: 0
    t.boolean  "published",                      default: false
    t.boolean  "one_run",                        default: false
  end

  add_index "exams", ["course_id"], name: "index_exams_on_course_id"
  add_index "exams", ["lesson_category_id"], name: "index_exams_on_lesson_category_id"

  create_table "invitations", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.string   "email"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "slug"
    t.boolean  "accepted",   default: false
  end

  add_index "invitations", ["course_id"], name: "index_invitations_on_course_id"
  add_index "invitations", ["user_id"], name: "index_invitations_on_user_id"

  create_table "lesson_categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "flagged",                default: false
  end

  add_index "lesson_categories", ["course_id"], name: "index_lesson_categories_on_course_id"

  create_table "lessons", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lesson_category_id"
    t.integer  "course_id"
    t.text     "content",                        default: ""
  end

  add_index "lessons", ["course_id"], name: "index_lessons_on_course_id"
  add_index "lessons", ["lesson_category_id"], name: "index_lessons_on_lesson_category_id"

  create_table "material_categories", force: :cascade do |t|
    t.integer  "lesson_category_id"
    t.string   "name"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "material_categories", ["lesson_category_id"], name: "index_material_categories_on_lesson_category_id"

  create_table "materials", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "material_category_id"
  end

  add_index "materials", ["material_category_id"], name: "index_materials_on_material_category_id"

  create_table "pictures", force: :cascade do |t|
    t.string   "slug"
    t.string   "description",       default: ""
    t.integer  "lesson_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  add_index "pictures", ["lesson_id"], name: "index_pictures_on_lesson_id"

  create_table "question_categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "exam_id"
  end

  add_index "question_categories", ["exam_id"], name: "index_question_categories_on_exam_id"

  create_table "questions", force: :cascade do |t|
    t.integer  "exam_id"
    t.text     "name",                  limit: 255
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "form",                              default: 0
    t.integer  "question_category_id"
    t.integer  "correct_answers_count",             default: 0
    t.string   "picture_file_name",     limit: 255
    t.string   "picture_content_type",  limit: 255
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  add_index "questions", ["exam_id"], name: "index_questions_on_exam_id"
  add_index "questions", ["question_category_id"], name: "index_questions_on_question_category_id"

  create_table "user_answers", force: :cascade do |t|
    t.integer  "answer_id"
    t.integer  "user_exam_id"
    t.boolean  "correct"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "text",         limit: 255
    t.integer  "question_id"
  end

  add_index "user_answers", ["answer_id"], name: "index_user_answers_on_answer_id"
  add_index "user_answers", ["question_id"], name: "index_user_answers_on_question_id"
  add_index "user_answers", ["user_exam_id"], name: "index_user_answers_on_user_exam_id"

  create_table "user_exams", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "exam_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "result",     default: 0.0
    t.boolean  "closed",     default: false
  end

  add_index "user_exams", ["exam_id"], name: "index_user_exams_on_exam_id"
  add_index "user_exams", ["user_id"], name: "index_user_exams_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
