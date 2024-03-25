class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)

   if @comment.save!
    redirect_to movie_path(@movie)
   else

   end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
    .merge!(commentable: find_movie, user: current_user)
  end

  def find_movie
    @movie = Movie.find(params[:movie_id])
  end
end
