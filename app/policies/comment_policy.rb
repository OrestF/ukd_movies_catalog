class CommentPolicy < ApplicationPolicy
  def new?
    true
  end

  def edit?
    @user.comments.exists?(id: @record)
  end

  def update?
    edit?
  end
end
