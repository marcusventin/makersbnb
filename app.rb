require 'sinatra/base'
require 'sinatra/reloader'
require 'pg'
require './lib/user'
require './lib/space'
require './lib/availability'

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
    redirect '/makersbnb/log_in'
  end

  get '/makersbnb/add' do
    erb(:add)
  end

  post '/makersbnb/add' do
    Space.add(name: params[:property_name], description: params[:property_description],
    ppn: params[:ppn], start_date: params[:start_date], end_date: params[:end_date])
    
    redirect '/makersbnb/add/confirmation'
  end

  get '/makersbnb/add/confirmation' do
    @property = Space.all[-1]
    erb(:confirmation)
  end

  get '/makersbnb/properties' do
    @property_list = Space.all
    erb(:properties)
  end

  get '/makersbnb/space/:id' do
    @selected = Space.select(params[:id])
    @available_dates = Availability.select_availability(params[:id])
    erb(:view_space)
  end

  get '/makersbnb/space/:id/book/:date' do
    p params
    @chosen_date = params[:date]
    @selected = Space.select(params[:id])
    @available_dates = Availability.select_availability(params[:id])
    erb(:book_space)
  end

  get '/makersbnb/space/:id/book/:date/confirmation' do
  end

  get '/makersbnb/log_in' do
    erb :log_in
  end

  post '/makersbnb/log_in/confirmation' do
    # user = User.authenticate(email: params[:email], password: params[:password])
    # if user
    #   session[:user_id] = user.user_id
    #   redirect '/makersbnb/log_in/confirmation'
    # else
    #   flash[:notice] = 'Please check your email or password.'
    #   redirect'/makersbnb/log_in'
    # end
    redirect'/makersbnb/log_in'
  end

  run! if app_file == $PROGRAM_NAME
end
