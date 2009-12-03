require 'electro'

config.to_prepare do
  ApplicationController.helper(Electro::PagesHelper)
  ApplicationController.helper(Admin::Electro::PagesHelper)
end