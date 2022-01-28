require 'sinatra/base'
require 'sinatra/reloader'
require 'pg'
require './lib/user'
require './lib/space'
require './lib/availability'
require './lib/booking'

class MakersBnB < Sinatra::Base
  enable :sessions

  configure :development do
    register Sinatra::Reloader
  end

  get '/makersbnb' do
    erb :index 
  end

  get '/makersbnb/users/sign_up' do
    erb :sign_up
  end

  post '/makersbnb/users/sign_up' do
    User.sign_up(email: params[:email], password: params[:password])
    session[:user_id] = User.find_id
    redirect '/makersbnb'
  end

  get '/makersbnb/users/:user_id' do
    @user_space = Space.select_user(session[:user_id])
    erb :account
  end 
  
  get '/makersbnb/spaces/add' do
    erb(:add)
  end

  post '/makersbnb/spaces/add' do
    Space.add(
      name: params[:property_name], description: params[:property_description],
      ppn: params[:ppn], start_date: params[:start_date], end_date: params[:end_date],
      ownerid: session[:user_id]
    )
    
    redirect '/makersbnb/spaces/add/confirmation'
  end

  get '/makersbnb/spaces/add/confirmation' do
    @property = Space.all[-1]
    erb(:confirmation)
  end

  get '/makersbnb/spaces' do
    @property_list = Space.all
    erb(:properties)
  end

  get '/makersbnb/spaces/:id' do
    @selected = Space.select(params[:id])
    @available_dates = Availability.select_availability(params[:id])
    erb(:view_space)
  end

  get '/makersbnb/spaces/:id/book/:date' do
    @chosen_date = params[:date]
    @selected = Space.select(params[:id])
    @available_dates = Availability.select_availability(params[:id])
    erb(:book_space)
  end

  post '/makersbnb/spaces/:id/book/:date/confirmation' do
    Booking.create(date: params[:date], spaceid: params[:id],
      tenantid: session[:user_id], status: 'pending')
    redirect '/makersbnb/spaces/book/confirmation'
  end

  get '/makersbnb/spaces/book/confirmation' do
    'Your booking request has been submitted'
  end

  run! if app_file == $PROGRAM_NAME
end

# We can use spaceid to link to owner, property name
