# Add your unit tests.
# You want to test your interaction with the database here.
ENV['APP_ENV'] = 'test'

require_relative '../app.rb'
require 'minitest/autorun'
require 'rack/test'

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe "GET on /users" do
  before do
    User.delete_all
    User.create(
        name: "paul",
        email: "paul@gmail.com",
        password: "foo",
        bio: "Student")

    User.create(
        name: "chris",
        email: "chris@gmail.com",
        password: "haha",
        bio: "Student")
  end

  it "Should return users in a list" do
    get '/users'
    last_response.ok?
    attributes = JSON.parse(last_response.body)
    attributes.must_be_instance_of Array
  end

end


describe "Post on /users" do

  it "Should create n users" do
    post '/users?n=2'
    last_response.ok?.must_equal true
  end

  it "Should create n users" do
    post '/users?n=40'
    last_response.ok?.must_equal false
  end
end

describe "Post on /users/destroy" do

  it "Should delete all users" do
    post '/users/destroy'
    if last_response.ok?
    users = User.all
    users.count.must_equal 0
    end
  end
end
