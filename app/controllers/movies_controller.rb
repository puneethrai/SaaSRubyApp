class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @movies = Movie.all
    @ratings = params[:ratings]
    @all_ratings = ['G','PG','PG-13','R']
    puts @ratings
    if(@ratings==nil)
      @ratings = {"G"=>"1","PG"=>"1","PG-13"=>"1","R"=>"1"}
    end
    if(params[:commit]=="Refresh")
      if(params[:ratings])
       ratings=params[:ratings].keys
       @movies = Movie.where("rating IN (?)", ratings)
         if(params[:by])
            @movies = @movies.order(params[:by])
            @sort=params[:by]
         end
       else
         @movies = []
       end
    elsif(params[:by]=="title")
	     @movies = Movie.order(params[:by]).all
    	 @sort="title"
    elsif(params[:by]=="rating")
	     @movies = Movie.order(params[:by]).all
	     @sort = "rating"
    elsif(params[:by]=="release_date")
	     @movies = Movie.order(params[:by]).all
	     @sort = "release_date"
    
    end
      

  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
