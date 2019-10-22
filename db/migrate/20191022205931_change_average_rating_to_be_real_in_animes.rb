class ChangeAverageRatingToBeRealInAnimes < ActiveRecord::Migration[5.0]
  # def change
  #   change_column :animes, :average_rating, :real
  # end

  def up 
    change_column :animes, :average_rating, :float
  end

  def down
    change_column :animes, :average_rating, :integer
  end
end
