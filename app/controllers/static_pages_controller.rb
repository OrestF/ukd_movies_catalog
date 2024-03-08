class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: :secret
  
  def home
    @welcome_message = "Welcome to the Ruby on Rails Movies Catalog app"
  end

  def secret
  end
end