# entry point
require 'sinatra'
require 'net/http'
require 'json'

# retrieve your api host address like this
#   settings.api => "someaddress.ondigitalocean.com"
set :api, ENV['API_HOST']
set :api_port, ENV['API_PORT'] || 80


# Show a pretty table of all users... rendered on a html page.
get '/' do
  res =  Net::HTTP.get_response(settings.api, '/users', settings.api_port)
  @users = JSON.parse(res.body)
  erb :index
end

post '/users' do
  uri = URI("http://#{settings.api}" + ":#{settings.api_port}" + '/users' )
  Net::HTTP.post_form(uri, {"n" => params["n"]})
  redirect '/'
end

post '/users/destroy' do
  uri = URI("http://#{settings.api}" + ":#{settings.api_port}" + '/users/destroy' )
  puts uri
  Net::HTTP.post_form(uri,params)
  redirect '/'
end
