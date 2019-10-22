base_url = "https://kitsu.io/api/edge/anime"

response_chihaya = RestClient.get("https://kitsu.io/api/edge/anime?filter[text]=chihayafuru")

json_data = JSON.parse(response_chihaya)["data"][0]

#all my info is in converted_to_json["data"][0]

binding.pry
0