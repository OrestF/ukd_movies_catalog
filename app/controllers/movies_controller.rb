class MoviesController < ApplicationController
  before_action :find_movie, only: %i[show edit update destroy]

  # GET /movies
  def index
    @movies = Movie.all
  end

  # GET /movies/:id
  def show
    @omdb = OmdbClient.new
    @omdb_movie = @omdb.find_by_title(@movie.title)
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # POST /movies
  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      flash[:notice] = 'Movie created'
      redirect_to @movie
    else
      flash[:alert] = @movie.errors.full_messages.join(", ")
      redirect_to new_movie_path
    end
  end

  # GET /movies/:id/edit
  def edit
  end

  # PUT/PATCH /movies/:id
  def update
    @movie.assign_attributes(movie_params)
    if @movie.save
      redirect_to @movie
    else
      flash.now[:alert] = @movie.errors.full_messages.join(", ")
      redirect_to @movie 
    end
  end

  # DELETE /movies/:id
  def destroy
    @movie.destroy!
    
    respond_to do |format|
      format.html { redirect_to movies_path, flash: 'Movie destroyed' }
      format.json { head :no_content }
    end
  end


  def omdb_search
    if params[:search_query].present?
      @omdb = OmdbClient.new

      # @search_results = @omdb.search(params[:search_query])['Search']
      res = @omdb.search(params[:search_query])
      @search_results = res['Search']
    end
  end

  def omdb_import
    @omdb = OmdbClient.new

    @omdb_movie = @omdb.find_by_id(params[:omdb_id])

    @movie = Movie.new(
      title: @omdb_movie['Title'],
      cover_image_url: @omdb_movie['Poster'],
      year_of_creation: @omdb_movie['Year'],
      description: @omdb_movie['Plot'],
      duration: @omdb_movie['Runtime'],
      director: @omdb_movie['Director'],
      genres: @omdb_movie['Genre'].split(', ')
    )
    if @movie.save
      redirect_to @movie
    else
      flash[:alert] = @movie.errors.full_messages.join(", ")
      redirect_to omdb_search_movies_path
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :description, :duration, :director, :year_of_creation, :cover_image_url, genres: [])
  end

  def find_movie
    @movie = Movie.find(params[:id])
  end
end