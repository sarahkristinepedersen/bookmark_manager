require 'sinatra/base'
# require 'data_mapper'
require_relative './data_mapper_setup'

class BookmarkManager < Sinatra::Base

  get '/' do
    erb :home_page
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links/' do
    Link.create(url: params[:url], title: params[:title])
    redirect to('/links')
  end


end