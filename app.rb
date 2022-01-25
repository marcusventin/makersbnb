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
    Space.add(name: params[:property_name], description: params[:description], ppn: params[:ppn])
    redirect '/add-confirmation'
  end

  get '/add-confirmation' do
    @property = Space.all[0]
    erb(:confirmation)
  end

  run! if app_file == $PROGRAM_NAME
end
