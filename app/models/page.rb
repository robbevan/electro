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