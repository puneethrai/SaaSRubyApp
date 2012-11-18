class CreateMovies < ActiveRecord::Migration
  def up
    create_table :movies do |t|
      t.string :title
      t.string :rating
      t.text :description
      t.datetime :release_date
      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
      t.timestamps
    end
  end

  def down
    drop_table :movies
  end
class AddReviews < ActiveRecord::Migration
  def self.up
    create_table :reviews do |t|
      t.integer 'potatoes' 
  t.references 'movie'
      t.references 'moviegoer'
    end
  end
end
class CreateGenresMovies < ActiveRecord::Migration
  def up
    create_table 'genres_movies', :id => false do t
      t.references 'genres'
      t.references 'movies'
    end
  end
  def down
    drop_table 'genres_movies'
  end
end

end
