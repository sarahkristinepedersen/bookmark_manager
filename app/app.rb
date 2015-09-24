require "sinatra/base"
require 'sinatra/flash'


# require 'data_mapper'
require_relative "data_mapper_setup"
require_relative "helpers"

class BookmarkManager < Sinatra::Base
include Helpers

enable :sessions
set :session_secret, "super secret"
register Sinatra::Flash


  get "/" do
    erb :home_page
  end

  get "/links" do
    @links = Link.all
    erb :"links/index"
  end

  get "/links/new_link" do
    erb :"links/new_link"
  end

  post "/links" do
    link = Link.create(url: params[:url], title: params[:title])
    params[:tag].downcase.split.each do |tag|
      tag = Tag.create(name: tag)
      link.tags << tag
    end
    link.save
    redirect to("/links")
  end

  get "/tags/:name" do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :"links/index"
  end

  get '/users/new_user' do
    @user = User.new
    erb :'users/new_user'
  end

  post "/users" do
    @user = User.create(email: params[:email],
                       password: params[:password],
                       password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect to("/links")
    else
      flash.now[:errors] = @user.errors.full_messages
      # flash.now[:notice] = "Password and confirmation password do not match"
      erb :"users/new_user"
    end
  end



  run! if app_file == BookmarkManager
end

