class ProposalPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      if user.admin?
        scope.all
      else
        scope.all # TODO, filter by user
      end
    end
  end


  # TODO: filter by permissions.
  def index?
    true
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    show?
  end

  def edit?
    update?
  end

  def destroy?
    show?
  end
  alias :decide? :create?
end
