class CommentMailer < ApplicationMailer
  def created
    @user = params[:user]
    comment_to = params[:comment].commentable
    @movie = comment_to.is_a?(Movie) ? comment_to : comment_to.commentable
    @subject = 'New comment created'

    mail to: @user.email, subject: @subject
  end
end
