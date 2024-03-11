json.extract! film, :id, :title, :director, :release_date, :description, :duration, :created_at, :updated_at
json.url film_url(film, format: :json)
