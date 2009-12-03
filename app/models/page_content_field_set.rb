# == Schema Information
# Schema version: 20081127172013
#
# Table name: page_content_field_sets
#
#  id             :integer(4)      not null, primary key
#  name           :string(255)
#  content_fields :text
#  created_at     :datetime
#  updated_at     :datetime
#

class PageContentFieldSet < ActiveRecord::Base
  has_many :pages

  validates_presence_of :name
  validates_uniqueness_of :name

  serialize :content_fields, Hash
end