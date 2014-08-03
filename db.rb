require 'dotenv';Dotenv.load
require 'sequel'

DB = Sequel.connect(ENV.fetch('DATABASE_URL'))

DB.create_table? :messages do
  primary_key :id
  String :from
  String :to
  String :body
  String :request
  DateTime :created_at
end
