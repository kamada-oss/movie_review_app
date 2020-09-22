class LikesController < ApplicationController
  before_action :set_cast
  
  def create
    book = current_user.likes.new(cast_id: @cast.id)
    book.save
    redirect_back(fallback_location: root_path)
  end
  
  def destroy
    book = current_user.likes.find_by(cast_id: @cast.id)
    book.destroy
    redirect_back(fallback_location: root_path)
  end
  
  private
    def set_cast
      @cast = Cast.find(params[:cast_id])
    end
end
