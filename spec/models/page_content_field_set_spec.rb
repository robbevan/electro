require 'spec/spec_helper'

describe PageContentFieldSet do
  def new_page_content_field_set(options={})
    @page_content_field_set = PageContentFieldSet.new({ :name => 'Default' }.merge(options))
  end
  
  def create_page_content_field_set(options={})
    @page_content_field_set = PageContentFieldSet.create({ :name => 'Default' }.merge(options))
  end

  describe "associations and validations" do
    before(:each) do
      new_page_content_field_set
    end
    
    it "should have many Pages" do
      @page_content_field_set.should have_many(:pages)
    end

    it "should validate presence of name" do
      @page_content_field_set.should validate_presence_of(:name)
    end
  end

  describe "when new" do
    it "should be valid given valid attributes" do
      new_page_content_field_set
      @page_content_field_set.should be_valid
    end

    it "should not be valid without a name" do
      new_page_content_field_set({ :name => nil })
      @page_content_field_set.should_not be_valid
    end

    it "should not be valid without a unique name" do
      create_page_content_field_set
      new_page_content_field_set
      @page_content_field_set.should_not be_valid
    end
  end
  
  describe "on create" do
    it "should serialize the content fields attribute as a Hash" do
      content_fields = { :title => 'title', :body => 'body' }
      page_content_field_set = create_page_content_field_set({ :content_fields => content_fields })
      page_content_field_set.content_fields.class.should == Hash
      page_content_field_set.content_fields[:title].should == 'title'
    end
 
    it "should raise SerializationTypeMismatch if the content fields attribute is not a Hash" do
      lambda {
        create_page_content_field_set({ :content_fields => %w( one two three ) })
      }.should raise_error(ActiveRecord::SerializationTypeMismatch)
    end
  end
end
