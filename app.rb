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

  get '/makersbnb/sign_up' do
    erb :sign_up
  end

  post '/makersbnb/sign_up' do
    User.sign_up(user_name: params[:user_name], password: params[:password])
    p session[:user_id] = User.find_id
    redirect '/makersbnb'
  end

  get '/makersbnb/add' do
    erb(:add)
  end

  post '/makersbnb/add' do
    Space.add(
      name: params[:property_name], description: params[:property_description],
      ppn: params[:ppn], start_date: params[:start_date], end_date: params[:end_date],
      ownerid: session[:user_id]
    )
    
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
    @chosen_date = params[:date]
    @selected = Space.select(params[:id])
    @available_dates = Availability.select_availability(params[:id])
    session[:user] = 'stand-in user'
    erb(:book_space)
  end

  post '/makersbnb/space/:id/book/:date/confirmation' do
    
    Booking.create(date: params[:date], spaceid: params[:id],
      tenantid: session[:user_id], status: 'pending')
    redirect '/makersbnb/book/confirmation'
  end

  get '/makersbnb/book/confirmation' do
    'Your booking request has been submitted'
  end

  get "/makersbnb/:user_id" do
    p session[:user_id]
    p @user_space = Space.select_user(session[:user_id])
    erb :account
  end 

  run! if app_file == $PROGRAM_NAME
end

# We can use spaceid to link to owner, property name
