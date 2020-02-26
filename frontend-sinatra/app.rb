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

  # puts res.code
  # puts res.message
  # puts res.body

  erb :index
end

post '/users' do
  uri = URI("http://#{settings.api}" + ":#{settings.api_port}" + '/users' )
  input = params["n"]
  input.strip!
  input = "1" if input.length == 0
  res = Net::HTTP.post_form(uri, {"n" => input})
  code = res.code.to_i
  if code >= 400
    erb :error
  else
    redirect '/'
  end

end

post '/users/destroy' do
  uri = URI("http://#{settings.api}" + ":#{settings.api_port}" + '/users/destroy' )
  res = Net::HTTP.post_form(uri,params)
  code = res.code.to_i
  if code >= 400
    erb :error
  else
    redirect '/'
  end
end
