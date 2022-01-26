require 'sinatra/base'
require 'sinatra/reloader'
require 'pg'
require './lib/user'

class MakersBnB < Sinatra::Base
  enable :sessions

  configure :development do
    register Sinatra::Reloader
  end

  get '/makersbnb' do
    erb :index
  end

  get '/makersbnb/sign_up' do
    erb :sign_up
  end

  post '/makersbnb/sign_up' do
    User.sign_up(user_name: params[:user_name], password: params[:password])
    redirect '/makersbnb'
  end

  get '/makersbnb/add' do
    erb(:add)
  end

  post '/makersbnb/add' do
    Space.add(name: params[:property_name], description: params[:description],
      ppn: params[:ppn], start_date: params[:start_date], end_date: params[:end_date])
    redirect '/makersbnb/add-confirmation'
  end

  get '/makersbnb/add-confirmation' do
    @property = Space.all[0]
    erb(:confirmation)
  end

  run! if app_file == $PROGRAM_NAME
end
