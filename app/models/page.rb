# == Schema Information
# Schema version: 20081127172013
#
# Table name: pages
#
#  id                        :integer(4)      not null, primary key
#  name                      :string(255)
#  slug                      :string(255)
#  content                   :text
#  status                    :string(255)
#  page_content_field_set_id :integer(4)
#  page_status_set_id        :integer(4)
#  created_at                :datetime
#  updated_at                :datetime
#

class Page < ActiveRecord::Base
  belongs_to :page_content_field_set
  
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_uniqueness_of :slug

  serialize :content
  
  after_save :update_slug
  
  class << self
    def find_with_published_scope(*args)
      with_scope(:find => { :conditions => "published = 1" }) do
        find(*args)
      end
    end
    
    def find_by_slug(params, options={})
      conditions = ['slug = ?', (params[:name] ? params[:name].first : params[:id]).to_s.downcase]
      if options[:admin]
        find(:first, :conditions => conditions)
      else
        find_with_published_scope(:first, :conditions => conditions)
      end
    end

    def find_for_sitemap
      find_with_published_scope(:all, :conditions => ['sitemap = ?', true])
    end
  end
  
  def title
    name
  end

  def slug
    (read_attribute(:slug).blank?) ? underscore(name) : read_attribute(:slug)
  end
  alias :permalink :slug

  def update_slug
    update_attribute(:slug, underscore(name)) if read_attribute(:slug).blank?
  end

  def content_fields
    page_content_field_set.content_fields rescue {}
  end
  
  protected
  
    def underscore(text)
      ActiveSupport::Inflector.underscore(text).
      gsub(/&/, " and ").
      gsub(/[^a-zA-Z0-9\s]/, '').
      tr_s(" ", "_").
      downcase
    end
end
