module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  def index_path(argument)
    return "/movies"+"?"+"by="+argument
    
  end
end
