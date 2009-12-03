if defined?(ActionController::Routing::RouteSet)
  class ActionController::Routing::RouteSet
    def load_routes_with_electro!
      lib_path = File.dirname(__FILE__)
      electro_routes = File.join(lib_path, *%w[.. .. .. config electro_routes.rb])
      unless configuration_files.include?(electro_routes)
        add_configuration_file(electro_routes)
      end
      load_routes_without_electro!
    end

    alias_method_chain :load_routes!, :electro
  end
end

