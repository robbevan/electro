class Electro::PagesController < ApplicationController
  unloadable
  # GET /pages/:id
  def show
    @page = Page.find_by_slug((params[:name] ? params[:name].first : params[:id]).to_s.downcase)
    if (@content = (@page.content rescue {})).blank?
      render(:file => "#{RAILS_ROOT}/public/404.html", :status => 404, :layout => false) and return
    end
  end
end
