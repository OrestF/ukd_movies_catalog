class CommentsController < ApplicationController
  before_action :find_movie, only: :create
  
  def create
    @comment = @movie.comments.build(user: current_user, **comment_params)

    flash[:error] = @comment.errors.full_messages.join(", ") unless @comment.save

    redirect_to @movie
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_movie
    @movie = Movie.find(params[:movie_id])
  end
end
