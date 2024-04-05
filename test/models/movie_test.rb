require "test_helper"

class MovieTest < ActiveSupport::TestCase
  test 'should create a movie record' do
    movie = Movie.new(title: 'test', 
    description: '1234567890',
    year_of_creation: 2023, 
    genres: ['action'])
    assert_equal movie.save, true
  end
end