require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative "cookbook"
require_relative "recipe"

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  @cookbook = Cookbook.new(File.join(__dir__, 'recipes.csv'))
  erb :list
end

get '/new' do
  erb :new
end

get '/about' do
  @names = %w(Jasmine Ben Mark)

  erb :about
end

get '/team/:team' do
  @team = params[:team]

  erb :team
end

get "/search" do
  @keyword = params[:keyword]
  @sorted_by = params[:sort]

  erb :search
end

post '/new_recipe' do
  @cookbook = Cookbook.new(File.join(__dir__, 'recipes.csv'))
  new_recipe = Recipe.new(params)
  @cookbook.add_recipe(new_recipe)

  erb :list
  redirect to('/')
end
