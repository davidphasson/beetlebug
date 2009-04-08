ActionController::Routing::Routes.draw do |map|
  map.resources :requests, :member => { :email => :get }
  map.root :controller => 'requests', :action => 'new'
end
