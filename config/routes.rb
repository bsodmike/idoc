ActionController::Routing::Routes.draw do |map|

  map.namespace :admin do |admin|
    admin.resource :moderator_list, :controller => :moderator_list, :only => [:edit, :update, :show]
  end

  map.resource :user_session

  map.resources :users, :collection => {:confirm => :get}

  map.resources :documentation_pages, :as => "page" do |doc|
    doc.resources :comments
  end

  map.root :controller => :documentation_pages, :action => :root
end
