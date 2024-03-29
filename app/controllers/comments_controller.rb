class CommentsController < ApplicationController
  before_action :find_movie
  before_action :find_and_authorize_comments, except: :create
  
  def create
    # @comment = @movie.comments.build(user: current_user, **comment_params)
    @comment = Comment.new(comment_params.merge!(user: current_user, commentable: @movie))

    flash[:alert] = @comment.errors.full_messages.join(", ") unless @comment.save

    redirect_to @movie
  end

  def edit
  end

  def update
    @comment.assign_attributes(comment_params)
    if @comment.save
      redirect_to @comment.commentable
    else
      flash[:alert] = @comment.errors.full_messages.join(", ")
      render :edit
    end
  end

  def destroy
    @comment.destroy!
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_movie
    @movie = Movie.find(params[:movie_id])
  end

  def find_and_authorize_comment
    @comment = Comment.find(params[:id])
    authorize @comment
  end
end
