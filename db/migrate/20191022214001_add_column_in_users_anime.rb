class AddColumnInUsersAnime < ActiveRecord::Migration[5.0]
  def change
    add_column :users_animes, :finished, :boolean
  end
end
