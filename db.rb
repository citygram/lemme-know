require 'dotenv';Dotenv.load
require 'sequel'

DB = Sequel.connect(ENV.fetch('DATABASE_URL'))
DB.extension :pagination
DB.create_table? :messages do
  String :from
  String :to
  String :body
  DateTime :created_at
end
