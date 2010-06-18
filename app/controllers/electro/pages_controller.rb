class Electro::PagesController < ApplicationController
  unloadable
  # GET /pages/:id
  def show
    if @page = Page.find_by_slug(params, options)
      if template_exists?(template)
        set_meta
        render(:template => template) and return
      else
        begin
          @content = @page.content
          set_meta
        rescue
          render_not_found and return
        end
      end
    else
      render_not_found
    end
  end
  
  protected
  
    def options
      returning ({}) do |options|
        options[:admin] = admin? rescue false
      end
    end
  
    def template
      "electro/pages/#{params[:name]}"
    end
  
    def template_exists?(template)
      view_paths.find_template(template, response.template.template_format)
    rescue ActionView::MissingTemplate
      false
    end
    
    def set_meta
      @page_title = @page.title
      @page_description = @page.description if @page.description
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
