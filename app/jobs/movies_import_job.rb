class MoviesImportJob < ApplicationJob
  queue_as :default

  def perform(omdb_id, current_user)
    @omdb = OmdbClient.new

    @omdb_movie = @omdb.find_by_id(omdb_id)

    @movie = Movie.new(
      title: @omdb_movie['Title'],
      cover_image_url: @omdb_movie['Poster'],
      year_of_creation: @omdb_movie['Year'],
      description: @omdb_movie['Plot'],
      duration: @omdb_movie['Runtime'],
      director: @omdb_movie['Director'],
      genres: @omdb_movie['Genre'].split(', ')
    )

    MovieMailer.with(user: current_user, movie: @movie)
               .import_complete
               .deliver_now if @movie.save!
  end
end