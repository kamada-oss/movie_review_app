class StaticPagesController < ApplicationController
  def home
    @movies = Movie.order('id ASC').limit(5)
    @dramas = Drama.order('id ASC').limit(5)
  end

  def help
  end
  
  def about
  end
end
