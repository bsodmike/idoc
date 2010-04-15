class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user
    if is_logged_in?
      setup_anonymous_permissions
    elsif is_administrator_user?
      setup_administrator_permissions
    elsif is_moderator_user?
      setup_moderator_permissions
    else
      setup_logged_in_permissions
    end
  end

  private

  def is_logged_in?
    @user.nil?
  end

  def is_administrator_user?
    @user.admin
  end

  def is_moderator_user?
    @user.moderator
  end

  def setup_anonymous_permissions
    can :read, [DocumentationPage, Comment]
    can :create, [User, UserSession]
    can :confirm, User
  end

  def setup_administrator_permissions
    can :manage, :all
    can :destroy, DocumentationPage do |doc_page|
      doc_page.children.empty?
    end
    cannot :create, UserSession
    cannot [:create, :destroy], ModeratorList
  end

  def setup_moderator_permissions
    can :manage, [DocumentationPage, Comment]
    can_control_own_user_only
    can_control_own_user_session_only
  end

  def setup_logged_in_permissions
    can :manage, DocumentationPage
    can [:read, :create], Comment
    can_control_own_user_only
    can_control_own_user_session_only
  end

  def can_control_own_user_only
    can [:update, :destroy, :read], User do |u|
      u == @user
    end
  end

  def can_control_own_user_session_only
    can [:update, :destroy, :read], UserSession do |us|
      us.record == @user
    end
  end
end