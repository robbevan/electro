module Electro::PagesHelper
  def page(name, key=:body)
    if page = Page.find_by_name(name)
      page_content_for(page.content, :key => key)
    end
  end
    
  def page_content_for(content, options={})
    options = { :key => options } if options.is_a?(Symbol)
    if content.is_a?(Hash)
      content[options[:key]] if options[:key]
    else
      options[:key] ? (content if (options[:accept_default] == true)) : content
    end
  end
end
