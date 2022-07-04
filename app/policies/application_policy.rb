class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def show?
    @user == @record.user
  end

  def create?
    true
  end

  def new?
    true
  end

  def edit?
    @user == @record.user
  end

  def update?
    @user == @record.user
  end

  def destroy?
    @user == @record.user
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end
end
