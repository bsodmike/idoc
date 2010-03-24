ActionController::Routing::Routes.draw do |map|

  map.resource :user_session

  map.resources :users, :collection => {:confirm => :get}

  map.resources :documentation_pages, :as => "page" do |doc|
    doc.resources :comments
  end

  map.root :controller => :documentation_pages, :action => :root
end
