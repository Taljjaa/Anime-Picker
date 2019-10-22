base_url = "https://kitsu.io/api/edge/anime?filter[text]="

response_chihaya = RestClient.get("https://kitsu.io/api/edge/anime?filter[text]=chihayafuru")

json_data_chi = JSON.parse(response_chihaya)["data"][0]

title = json_data_chi["attributes"]["titles"]["en"]
avg_count = json_data_chi["attributes"]["averageRating"].to_f
date = json_data_chi["attributes"]["startDate"]
count = json_data_chi["attributes"]["episodeCount"]
api_id = json_data_chi["id"].to_i


#all my info is in converted_to_json["data"][0]

Anime.create(title: title, average_rating: avg_count, start_date: date, episode_count: count, api_id: api_id)

binding.pry
0