class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  
  def home
    @welcome_message = "Welcome to the Ruby on Rails Movies Catalog app"
  end

  def secret
  end
end