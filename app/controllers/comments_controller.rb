class CommentsController < ApplicationController
  before_action :find_movie, only: :create
  
  def create
    # @comment = @movie.comments.build(user: current_user, **comment_params)
    @comment = Comment.new(comment_params.merge!(user: current_user, commentable: @movie))

    flash[:error] = @comment.errors.full_messages.join(", ") unless @comment.save

    redirect_to @movie
  end

  def edit
    @comment = Comment.find(params[:id])

    authorize @comment
  end

  def update
    @comment = Comment.find(params[:id])

    @comment.assign_attributes(comment_params)
    if @comment.save
      redirect_to @comment.commentable
    else
      flash[:error] = @comment.errors.full_messages.join(", ")
      render :edit
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_movie
    @movie = Movie.find(params[:movie_id])
  end
end
