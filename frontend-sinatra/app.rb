# entry point
require 'sinatra'
require 'net/http'
require 'json'

# retrieve your api host address like this
#   settings.api => "someaddress.ondigitalocean.com"
set :api, ENV['API_HOST']
set :api_port, ENV['API_PORT'] || 80
root = '157.245.113.67/users'
uri = URI(root)

# Show a pretty table of all users... rendered on a html page.
get '/' do
  res =  Net::HTTP.get_response(ENV['API_HOST'] + "/users", ENV['API_PORT'])
  @users = JSON.parse(res.body)
  erb :index
end

post '/users' do
  Net::HTTP.post_form(URI(root), {"n" => params["n"]})
  redirect '/'
end

post '/users/destroy' do
  Net::HTTP.post_form(URI(root + '/destroy'),params)
  redirect '/'
end


