class Ability
  include CanCan::Ability

  def initialize(user)
    if user.nil?
      can :read, :all
    elsif user.admin
      can :manage, :all
    elsif user.moderator
      can :manage, :all
    else
      can :manage, :all
      cannot [:update, :destroy], Comment
    end
  end
end