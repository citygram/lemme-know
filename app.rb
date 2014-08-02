require 'dotenv';Dotenv.load
require 'sinatra'
require './db'

post '/messages' do
  puts params
  DB[:messages].insert(
    from: params['From'],
    to: params['To'],
    body: params['Body'],
    created_at: DateTime.now
  )

  200
end

get '/' do
  @messages = DB[:messages].order(Sequel.desc(:created_at)).paginate(
    params[:page] || 1,
    params[:limit] || 100
  )

  @messages = @messages.where(Sequel.ilike(:from, '%'+params['from']+'%')) if params['from']
  @messages = @messages.where(Sequel.ilike(:to, '%'+params['to']+'%')) if params['to']
  @messages = @messages.where(Sequel.ilike(:body, '%'+params['body']+'%')) if params['body']

  erb :index
end
