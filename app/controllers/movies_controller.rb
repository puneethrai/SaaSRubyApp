class MoviesController < ApplicationController
  @MoviePage=1
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
        # redirect if ratings / table sort not specified but saved in session
    @ratings = params[:ratings]
    @sort_by = params[:by]
    session_ratings = (@ratings.nil? and !session[:ratings].nil?)
    session_sort_by = (@sort_by.nil? and !session[:sort_by].nil?)
    if session_ratings or session_sort_by
      if session_ratings
        # no ratings filter selected by user
        # session exists with ratings filter
        @ratings = session[:ratings]
      end
      if session_sort_by
        # no table sort specified by user
        # session exists with table sort
        @sort_by = session[:sort_by]
      end
      redirect_to :action => 'index', :ratings => @ratings, :by => @sort_by
    end
    
    # query database for all movies matching criteria
    @all_ratings = ['G','PG','PG-13','R']
    find_params = Hash.new
    
    if @ratings
      # user requested a rating filter
      ratings = @ratings.keys
      if ratings.length > 0
        find_params[:conditions] = ["rating IN (?)", ratings]
      end
      
      # save the ratings filter in a session
      session[:ratings] = @ratings
    else
      @ratings = Hash.new
    end
    
    if (@sort_by == 'title') or (@sort_by == 'release_date')
      # user requested a table sort
      find_params[:order] = @sort_by
      
      # save tje table sort in a session
      session[:sort_by] = @sort_by
    end
    
    @movies = Movie.find(:all, find_params)
  

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
