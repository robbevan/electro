module Admin::Electro::PagesHelper
  def content_fields(page)
    if page.content_fields.blank?
      content_tag(:p, "#{label(:content, :content)} #{text_area(:page, :content)}")
    else
      if page.content_fields.is_a?(Hash)
        fields = ''
        page.content_fields.each_pair do |key,value|
          fields << label(:content, "#{key}:")
          fields << '<br />' if value == 'textarea'
          fields << send(value, :content, key, :value => (ignore_nil { page.content[key] }))
          fields << '<br />'
        end
        content_tag(:p, fields)
      end
    end
  end
end