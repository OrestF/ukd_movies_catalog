class CommentPolicy < ApplicationPolicy
  def create?
    true
  end

  def update?
    record_owner?
  end
  
  def destroy?
    record_owner?
  end

  private

  def record_owner?
    @user.comments.exists?(id: @record)
  end
end
