class ProfilesController < ApplicationController
  def edit
  end

  def update
    if current_user.update(profile_params)
      flash[:notice] = 'Profile updated'
      redirect_to root_path
    else
      flash[:alert] = current_user.errors.full_messages.join(", ")
    end
  end

  private

  def profile_params
    params.require(:user).permit(:first_name, :last_name, :avatar)
  end
end
