require 'dotenv';Dotenv.load
require 'sinatra'
require './db'

configure :production do
  require 'rack/ssl'
  use Rack::SSL
end

post '/messages' do
  DB[:messages].insert(
    from: params['From'],
    to: params['To'],
    body: params['Body'],
    request: request.body.read,
    created_at: DateTime.now
  )

  200
end

order = {
  'asc' => Sequel.asc(:created_at),
  'desc' => Sequel.desc(:created_at)
}

get '/' do
  @messages = DB[:messages]

  @messages = @messages.order(order[params['order'] || 'desc'])
  @messages = @messages.where(Sequel.ilike(:from, '%'+params['from']+'%')) if params['from']
  @messages = @messages.where(Sequel.ilike(:to, '%'+params['to']+'%')) if params['to']
  @messages = @messages.where(Sequel.ilike(:body, '%'+params['body']+'%')) if params['body']

  erb :index
end
