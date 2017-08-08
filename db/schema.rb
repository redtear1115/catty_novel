# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_170_705_022_852) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'chapters', id: :serial, force: :cascade do |t|
    t.integer 'novel_id'
    t.text 'content'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'external_id'
    t.integer 'number', default: 0, null: false
    t.index ['external_id'], name: 'index_chapters_on_external_id', unique: true
    t.index %w[novel_id number], name: 'index_chapters_on_novel_id_and_number', unique: true
  end

  create_table 'collections', id: :serial, force: :cascade do |t|
    t.integer 'user_id'
    t.integer 'novel_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'last_read_chapter'
  end

  create_table 'identities', force: :cascade do |t|
    t.integer 'user_id'
    t.string 'provider'
    t.string 'uid'
    t.string 'email'
    t.string 'name'
    t.string 'token'
    t.string 'secret'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[uid provider], name: 'index_identities_on_uid_and_provider', unique: true
    t.index ['user_id'], name: 'index_identities_on_user_id'
  end

  create_table 'novels', id: :serial, force: :cascade do |t|
    t.string 'name'
    t.string 'author'
    t.string 'catgory'
    t.string 'source_url'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'last_sync_url'
    t.integer 'source_host_id'
    t.string 'status'
    t.boolean 'is_publish', default: true
    t.index ['source_url'], name: 'index_novels_on_source_url', unique: true
  end

  create_table 'source_hosts', id: :serial, force: :cascade do |t|
    t.string 'name'
    t.string 'url'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['url'], name: 'index_source_hosts_on_url', unique: true
  end

  create_table 'users', id: :serial, force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer 'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.string 'current_sign_in_ip'
    t.string 'last_sign_in_ip'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'name'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end
end
