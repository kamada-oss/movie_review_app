class CastsController < ApplicationController
  def show
    @cast = Cast.find(params[:id])
    movies = @cast.movies
    @movies_unique = movies.uniq
    dramas = @cast.dramas
    @dramas_unique = dramas.uniq
  end
  
  def show_drama
    @cast = Cast.find(params[:id])
    dramas = @cast.dramas
    @dramas_unique = dramas.uniq
    movies = @cast.movies
    @movies_unique = movies.uniq
  end
end
