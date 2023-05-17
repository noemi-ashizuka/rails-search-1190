Movie.destroy_all
TvShow.destroy_all
Director.destroy_all

movies = [
  "batman",
  "superman",
  "spiderman",
  "wonder woman",
  "thor",
  "black panther",
  "avengers"
]

puts "Creating movies..."      
movies.each do |title|
  omdb_endpoint = "http://www.omdbapi.com/?s=#{title}&apikey=a881ace5"

  serialized_data = URI.parse(omdb_endpoint).open.read
  results = JSON.parse(serialized_data)["Search"]
  
  results.each do |movie_hash|
    next if movie_hash["Poster"] == "N/A"
    omdb_endpoint = "http://www.omdbapi.com/?t=#{movie_hash["Title"].split.join("+")}&apikey=a881ace5"
    serialized_data = URI.parse(omdb_endpoint).open.read
    result = JSON.parse(serialized_data)

    director_first_name = result["Director"].split.first
    director_last_name = result["Director"].split.last
    
    director = Director.where(
                          first_name: director_first_name, 
                          last_name: director_last_name
                        )
                        .first_or_create!(
                          first_name: director_first_name,
                          last_name: director_last_name
                        )

    movie = Movie.where(
                    synopsis: result["Plot"]
                  )
                  .first_or_create!(
                    title: result["Title"], 
                    year: result["Year"].to_i, 
                    synopsis: result["Plot"], 
                    image_url: result["Poster"], 
                    director: director
                  )
    # p movie
    # p director
  end
end

url = "https://gist.githubusercontent.com/ssaunier/be9a933b64116e2422176aab7528473e/raw/d1e1b06e25616771fddf44bf066765f518b0655d/imdb.yml"
sample = YAML.load(URI.parse(url).read)

puts "Creating TV shows..."
sample["tv_shows"].each { |tv_show| TvShow.create!(tv_show) }
puts "Done."
