class Electro::PagesController < ApplicationController
  unloadable
  # GET /pages/:id
  def show
    template = "electro/pages/#{params[:name]}"
    render(:template => "electro/pages/#{params[:name]}") and return if template_exists?(template)
    @page = Page.find_by_slug((params[:name] ? params[:name].first : params[:id]).to_s.downcase)
    if (@content = (@page.content rescue {})).blank?
      render_not_found and return false
    end
  end
  
  protected
  
    def template_exists?(path)
      view_paths.find_template(path, response.template.template_format)
    rescue ActionView::MissingTemplate
      false
    end
    
    def render_not_found
      f = "#{RAILS_ROOT}/public/404.html"
      if File.exists?(f)
        render(:file => f, :status => 404, :layout => false)
      else
        render(:nothing => true, :status => 404)
      end
    end
end
