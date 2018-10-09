require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  n = 1
  while response_hash["next"] != nil
    response_string = RestClient.get("https://swapi.co/api/people/?page=#{n}")
    response_hash = JSON.parse(response_string)

    response_hash["results"].each { |features|
      if features["name"] == character
        return films_arr = features["films"].sort
      end
    }
  n+=1
  end
end

def print_movies(films_arr)
  # some iteration magic and puts out the movies in a nice list
  films_arr.each_with_index { |film_link, index|
    film_response_string = RestClient.get(film_link)
    film_response_hash = JSON.parse(film_response_string)

    puts "#{index+1} #{film_response_hash["title"]}"
  }
end

def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  print_movies(films_array)
end

## BONUS
# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
