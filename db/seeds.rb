base_url = "https://kitsu.io/api/edge/anime?filter[text]="

response_chihaya = RestClient.get("https://kitsu.io/api/edge/anime?filter[text]=chihayafuru")

json_data = JSON.parse(response_chihaya)["data"][0]

title = json_data["attributes"]["titles"]["en"]
avg_count = json_data["attributes"]["averageRating"]
api_id = json_data["id"]


#all my info is in converted_to_json["data"][0]

# seed_animes.each do |anime|
#     Anime.create(title: title, average_rating: avg_count, start_date: date, episode_count: count, api_id: api_id)
# end

binding.pry
0