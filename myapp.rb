require 'sinatra'
require 'sinatra/jbuilder.rb'

get '/' do  
  'Hello World'
end

get '/0.1/articles' do
  jbuilder :index
end