require 'sinatra/activerecord'

class User < ActiveRecord::Base
  def to_json(options={})
    options[:except] ||= [:password]
    super(options)
  end
end