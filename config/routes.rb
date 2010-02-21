ActionController::Routing::Routes.draw do |map|
  map.devise_for :users


  map.resources :documentation_pages

  map.root :controller => :documentation_pages, :action => :new
end
