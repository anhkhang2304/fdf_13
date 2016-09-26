class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can :read, :all
    end
  end

  def initialize(user, controller_namespace)
    case controller_namespace
      when "Admin"
        can :manage, :all if user.present? && user.admin?
        cannot :manage, :all if user.present? && !user.admin?
      else
    end
  end
end
