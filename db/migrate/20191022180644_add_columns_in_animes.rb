class AddColumnsInAnimes < ActiveRecord::Migration[5.0]
  def change
    add_column :animes, :average_rating, :integer
    add_column :animes, :start_date, :string
    add_column :animes, :episode_count, :integer
    add_column :animes, :api_id, :integer
  end
end
