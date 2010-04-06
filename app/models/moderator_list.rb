class ModeratorList

  def self.moderators
    User.find(:all).select(&:is_moderator?)
  end

  def self.users
    User.find(:all).reject(&:is_moderator?)
  end
end
