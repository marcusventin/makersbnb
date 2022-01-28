require 'sinatra/base'
require 'sinatra/reloader'
require 'pg'
require 'uri'
require 'sinatra/flash'

require './lib/user'
require './lib/space'
require './lib/availability'
require './lib/booking'

class MakersBnB < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

  configure :development do
    register Sinatra::Reloader
  end

  get '/makersbnb' do
    @user = User.find(user_id: session[:user_id])
    erb :index 
  end

  get '/makersbnb/users/sign_up' do
    erb :sign_up
  end

  post '/makersbnb/users/sign_up' do
    User.sign_up(email: params[:email], password: params[:password])
    session[:user_id] = User.find_id
    redirect '/makersbnb/users/log_in'
<<<<<<< HEAD
  end

  get '/makersbnb/users/log_in' do
    erb :log_in
  end

  post '/makersbnb/users/log_in/confirmation' do
    user = User.authenticate(email: params[:email], password: params[:password])
    if user
      session[:user_id] = user.user_id
      redirect '/makersbnb'
    else
      flash[:notice] = 'Please check your email or password.'
      redirect '/makersbnb/users/log_in'
    end
=======
>>>>>>> a97b911 (Updated signup route - redirects to log in page)
  end

  get '/makersbnb/users/log_in' do
    erb :log_in
  end

  post '/makersbnb/users/log_in' do
    user = User.authenticate(email: params[:email], password: params[:password])
    session[:user_id] = user.user_id
    redirect '/makersbnb'
  end

  post '/makersbnb/users/sign_out' do
    session.clear
    flash[:notice] = 'You have signed out.'
    redirect '/makersbnb'
  end

  get '/makersbnb/users/:user_id' do
    @user_space = Space.select_user(session[:user_id])
    @pending_bookings = Booking.view_pending(session[:user_id])
    @confirmed_bookings = Booking.view_confirmed(session[:user_id])
    erb :account
  end

  post '/makersbnb/users/:user_id/bookings/:bookingid/response' do
    Booking.confirm(params[:bookingid]) if params[:request_response] == 'Confirm Booking'
    Booking.decline(params[:bookingid]) if params[:request_response] == 'Decline Request'
    redirect '/makersbnb/users/:user_id'
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

<<<<<<< HEAD
=======

>>>>>>> 8b07e9d (Created a sign-out feature)
  # post '/makersbnb/signup' do
  #   # testing = 'test@testing.com' =~ URI::MailTo::EMAIL_REGEXP
  #   # p testing

  #   # if params['email'] =~ URI::MailTo::EMAIL_REGEXP
  #   User.sign_up(email: params[:email], password: params[:password])

  #   # else
  #   #   flash[:notice] = "You must submit a valid email address"
  #   # end

  #   redirect '/makersbnb/log_in'
  # end
