class DocumentAuthorList

  def self.authors
    User.find(:all).select(&:is_author?)
  end

  def self.users
    User.find(:all).reject(&:is_author?)
  end

  def self.update_list(modifications)
    if !modifications[:add_document_authors].blank?
      make_authors = User.find(modifications[:add_document_authors])
      make_authors.each{|new_author| new_author.document_author = true; new_author.save!}
    end
    if !modifications[:remove_document_authors].blank?
      unmake_authors = User.find(modifications[:remove_document_authors])
      unmake_authors.each{|author| author.document_author = false; author.save!}
    end
  end
end