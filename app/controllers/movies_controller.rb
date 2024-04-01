class MoviesController < ApplicationController
  # GET /movies
  def index
    @movies = Movie.all
  end

  # GET /movies/:id
  def show
    @movie = Movie.find(params[:id])
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
      redirect_to @movie
    else
      flash[:error] = @movie.errors.full_messages.join(", ")
      render :new
    end
  end

  # GET /movies/:id/edit
  def edit
    @movie = Movie.find(params[:id])
  end

  # PUT/PATCH /movies/:id
  def update
    @movie = Movie.find(params[:id])
    @movie.assign_attributes(movie_params)
    if @movie.save
      redirect_to @movie
    else
      flash[:error] = @movie.errors.full_messages.join(", ")
      render :edit
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

  private

  def movie_params
    params.require(:movie).permit(:title, :description, :duration, :director, :year_of_creation, genres: [])
  end
end