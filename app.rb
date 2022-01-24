require 'sinatra/base'
require 'sinatra/reloader'

class MakersBNB < Sinatra::Base
  enable :sessions

  configure :development do
    register Sinatra::Reloader
  end

  get '/add' do
    erb(:add)
  end

  post '/add' do
    session[:property_name] = params[:property_name]
    redirect '/add-confirmation'
  end

  get '/add-confirmation' do
    @property_name = session[:property_name]
    erb(:confirmation)
  end

  run! if app_file == $0
end
