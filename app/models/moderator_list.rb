class ModeratorList

  def self.moderators
    User.find(:all).select(&:is_moderator?)
  end

  def self.users
    User.find(:all).reject(&:is_moderator?)
  end

  def self.update_list(modifications)
    if !modifications[:add_moderators].blank?
      make_moderators = User.find(modifications[:add_moderators])
      make_moderators.each{|new_mod| new_mod.moderator = true; new_mod.save!}
    end
    if !modifications[:remove_moderators].blank?
      unmake_moderators = User.find(modifications[:remove_moderators])
      unmake_moderators.each{|mod| mod.moderator = false; mod.save!}
    end
  end
end
