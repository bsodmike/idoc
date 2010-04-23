ActionController::Routing::Routes.draw do |map|

  map.namespace :admin do |admin|
    admin.with_options :only => [:edit, :update, :show] do |admin_opts|
      admin_opts.resource :moderator_list, :controller => :moderator_list
      admin_opts.resource :document_author_list, :controller => :document_author_list
      admin_opts.resource :site_config, :controller => :site_config
    end
  end

  map.resource :user_session

  map.resources :users, :collection => {:confirm => :get}

  map.resources :documentation_pages,
                :as => "page",
                :collection => {:search => :get, :edit_tree => :get, :update_tree => :post} do |doc|
    doc.resources :comments
  end

  map.resources :comments, :collection => {:recent => :get}, :only => [:recent]

  map.root :controller => :documentation_pages, :action => :index
end
