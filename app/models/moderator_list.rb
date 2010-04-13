class ModeratorList

  def self.moderators
    User.find(:all).select(&:is_moderator?)
  end

  def self.users
    User.find(:all).reject(&:is_moderator?)
  end

  def self.update_list(modifications)
    make_moderators = User.find(modifications[:add_moderators])
    make_moderators.each{|new_mod| new_mod.moderator = true; new_mod.save!}
  end
end
