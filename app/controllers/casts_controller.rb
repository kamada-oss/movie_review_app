class CastsController < ApplicationController
  def show
    @cast = Cast.find(params[:id])
    movies = @cast.movies
    @movies_unique = movies.uniq
  end
end
