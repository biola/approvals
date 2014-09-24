class CommentPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      if user.admin?
        scope.all
      else
        scope.all # TODO, filter by user
      end
    end
  end

  # TODO make sure the user can comment
  def create?
    true
  end
end
