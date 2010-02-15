ActionController::Routing::Routes.draw do |map|

  map.resources :documentation_pages

  map.root :controller => :documentation_pages, :action => :new
end
