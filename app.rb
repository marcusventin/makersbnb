require 'sinatra/base'
require 'sinatra/reloader'
require 'pg'
require './lib/user'

class MakersBnB < Sinatra::Base

  get '/makersbnb' do
    erb :index
  end
  
  get '/makersbnb/sign_up' do
    erb :sign_up
  end

  post '/makersbnb' do
    User.sign_up(user_name: params[:user_name], password: params[:password])
    redirect '/makersbnb'
  end

end