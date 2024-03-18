class MoviesController < ApplicationController
  # GET /movies
  def index
    @movies = Movie.all
  end

  # GET /movies/:id
  def show
    @movie = Movie.find(params[:id])
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # POST /movies
  def create
  end

  # GET /movies/:id/edit
  def edit
  end

  # PUT/PATCH /movies/:id
  def update
  end

  # DELETE /movies/:id
  def destroy
  end
end