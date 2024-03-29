class CommentPolicy < ApplicationPolicy
  def new?
    true
  end

  def edit?
    @user.comments.exists?(id: @record)
  end
  alias destroy? edit?
  alias update? edit?

  # def update?
  #   edit?
  # end

  # def destroy?
  #   edit?
  # end
end
