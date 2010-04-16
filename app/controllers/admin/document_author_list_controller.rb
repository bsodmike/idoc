class Admin::DocumentAuthorListController < ApplicationController
  layout 'admin/application'
  
  def edit
    allowed_to? :update, DocumentAuthorList do
      @authors = DocumentAuthorList.authors
      @users = DocumentAuthorList.users
    end
  end

  def update
    allowed_to? :update, DocumentAuthorList do
      DocumentAuthorList.update_list(params[:document_author_list])
      construct_update_responses(params[:document_author_list])
      redirect_to admin_document_author_list_url
    end
  end

  def show
    allowed_to? :read, DocumentAuthorList do
      @authors = DocumentAuthorList.authors
    end
  end

  private

  def construct_update_responses(document_author_update_arrays)
    flash[:notice] = pluralize_author(document_author_update_arrays[:add_document_authors], " added")
    flash[:notice] = pluralize_author(document_author_update_arrays[:remove_document_authors], " removed")
  end

  def pluralize_author(array, ending)
    if array.blank?
      flash[:notice]
    else
      "Document author".smart_pluralize(array.size) + ending
    end
  end

end
