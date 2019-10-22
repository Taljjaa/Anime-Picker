base_url = "https://kitsu.io/api/edge/anime"

response_chihaya = RestClient.get("https://kitsu.io/api/edge/anime?filter[text]=chihayafuru")

converted_to_json = JSON.parse(response_chihaya)

binding.pry
0