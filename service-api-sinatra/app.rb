# entry point
require 'sinatra'
require 'json'
require 'faker'
require_relative './models/user'

# Retrieve all users from database.
get '/users' do
  @users = User.all
  @users = @users.map{ |x| x.attributes.except("password")}
  return @users.to_json
end


# Create n users.
post '/users' do
  count = params[:n].to_i || 1
  if count > 30
    return  400, {status: "400 bad request"}.to_json
  else
  count.times do
    User.create(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        bio: Faker::Hacker.say_something_smart,
        password: Faker::Number.number(digits:10).to_s
    )
  end
  return  200, {status: "200 ok"}.to_json
  end
end

# Delete all users.
post '/users/destroy' do
  if User.delete_all
    return  200, {status: "200 ok"}.to_json
  else
    return 500, {status: "500 Internal Error"}.to_json
  end
end
