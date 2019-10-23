def create_seedling(url)
    response = RestClient.get(url)
    json_data = JSON.parse(response)["data"][0]
    title = json_data["attributes"]["titles"]["en_us"]
    avg_count = json_data["attributes"]["averageRating"].to_f
    date = json_data["attributes"]["startDate"]
    count = json_data["attributes"]["episodeCount"]
    api_id = json_data["id"].to_i
    Anime.find_or_create_by(title: title, average_rating: avg_count, start_date: date, episode_count: count, api_id: api_id)
end

create_seedling("https://kitsu.io/api/edge/anime?filter[text]=steins%20gate")
create_seedling("https://kitsu.io/api/edge/anime?filter[text]=hunter%20x%20hunter")
create_seedling("https://kitsu.io/api/edge/anime?filter[text]=attack%20on%20titan")
create_seedling("https://kitsu.io/api/edge/anime?filter[text]=Ginga%20Eiyuu%20Densetsu")
create_seedling("https://kitsu.io/api/edge/anime?filter[text]=gintama")
create_seedling("https://kitsu.io/api/edge/anime?filter[text]=3%20gatsu%20no%20Lion%202nd%20Season")
create_seedling("https://kitsu.io/api/edge/anime?filter[text]=Made%20in%20Abyss")

binding.pry
0