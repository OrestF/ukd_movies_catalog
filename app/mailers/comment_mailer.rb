class CommentMailer < ApplicationMailer
  def created
    @user = params[:user]
    @comment = params[:comment]
    @subject = 'New comment created'

    mail to: @user.email, subject: @subject
  end
end
