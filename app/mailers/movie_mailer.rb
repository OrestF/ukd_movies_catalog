class MovieMailer < ApplicationMailer
  def import_complete
    @user = params[:user]
    @movie = params[:movie]

    mail to: @user.email, subject: 'Movie import complete!'
  end
end
