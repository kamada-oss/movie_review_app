class BooksController < ApplicationController
  before_action :set_movie_drama
  before_action :logged_in_user
  
  def create
    if params[:movie_id].nil?
      book = current_user.books.new(drama_id: @movie_drama.id)
    else
      book = current_user.books.new(movie_id: @movie_drama.id)
    end
    book.save
    redirect_back(fallback_location: root_path)
  end
  
  def destroy
    if params[:movie_id].nil?
      book = current_user.books.find_by(drama_id: @movie_drama.id)
    else
      book = current_user.books.find_by(movie_id: @movie_drama.id)
    end
    book.destroy
    redirect_back(fallback_location: root_path)
  end
  
  private
    def set_movie_drama
      if params[:movie_id].nil?
        @movie_drama = Drama.find(params[:drama_id])
      else
        @movie_drama = Movie.find(params[:movie_id])
      end
    end
    
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end
end
