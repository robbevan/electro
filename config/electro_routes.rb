ActionController::Routing::Routes.draw do |map|
  map.resources :pages, :controller => 'electro/pages', :only => [:index, :show]
    
  map.connect 'sitemap.xml', :controller => 'electro/pages', :action => :index
  map.connect '*name', :controller => 'electro/pages', :action => 'show'

  map.namespace(:admin) do |admin|
    admin.resources :pages, :controller => 'electro/pages'
    admin.resources :page_content_field_sets, :controller => 'electro/page_content_field_sets'
  end
end
