require './app'

username = ENV.fetch('BASIC_AUTH_USER')
password = ENV.fetch('BASIC_AUTH_PASSWORD')
use Rack::Auth::Basic, 'Restricted Area' do |u, p|
  u == username && p == password
end

run Sinatra::Application
