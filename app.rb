require 'sinatra/base'
require 'sinatra/reloader'

class MakersBnB < Sinatra::Base

  get '/makersbnb' do
    erb :index
  end
  
  get "/makersbnb/sign_up" do
    erb :sign_up
  end
end