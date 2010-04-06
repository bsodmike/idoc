class Ability
  include CanCan::Ability

  def initialize(user)
    if user.nil?
      can :read, :all
    elsif user.admin
      can :manage, :all
    else
      can :manage, :all
    end
  end
end