ActionController::Routing::Routes.draw do |map|
  map.resources :requests
  map.root :controller => 'requests', :action => 'new'
  
  map.connect ':controller/:action/:id', :controller => 'requests', :action => 'new'
end
