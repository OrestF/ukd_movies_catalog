class StaticPagesController < ApplicationController  
  def home
    @welcome_message = "Welcome to the Ruby on Rails Movies Catalog app"
  end
end