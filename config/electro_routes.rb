ActionController::Routing::Routes.draw do |map|
  map.resources :pages,
    :controller => 'electro/pages',
    :only       => [:show]
end
