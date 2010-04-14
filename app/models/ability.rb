class Ability
  include CanCan::Ability

  def initialize(user)
    if user.nil?
      can :read, :all
      can :create, User
      cannot :read, ModeratorList
      cannot :read, User
    elsif user.admin
      can :manage, :all
      cannot [:create, :destroy], ModeratorList
    elsif user.moderator
      can :manage, :all
      cannot :manage, ModeratorList
    else
      can :manage, :all
      cannot [:update, :destroy], Comment
      cannot :manage, ModeratorList
    end
  end
end