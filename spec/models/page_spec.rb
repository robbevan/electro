require 'spec/spec_helper'

describe Page do
  def new_page(options={})
    @page = Page.new({ :name => 'page' }.merge(options))
  end
  
  def create_page(options={})
    @page = Page.create({ :name => 'page' }.merge(options))
  end

  describe "associations and validations" do
    before(:each) do
      new_page
    end
    
    it "should belong to a PageContentFieldSet" do
      @page.should belong_to(:page_content_field_set)
    end
    
    it "should validate presence of name" do
      @page.should validate_presence_of(:name)
    end
  end
  
  describe "class methods" do
    after(:each) do
      Page.delete_all
    end
    
    describe ".find_by_slug" do
      it "should find a published page" do
        create_page
        Page.find_by_slug(:id => 'page').should == @page
      end

      it "should not find an unpublished page" do
        create_page(:published => false)
        Page.find_by_slug(:id => 'page').should == nil
      end
      
      context "when admin" do
        it "should find an unpublished page" do
          create_page(:published => false)
          Page.find_by_slug({:id => 'page'}, {:admin => true}).should == @page
        end
      end
    end
  end

  describe "when new" do
    it "should be valid given valid attributes" do
      new_page
      @page.should be_valid
    end

    it "should not be valid without a name" do
      new_page({ :name => nil })
      @page.should_not be_valid
    end

    it "should be invalid without a unique name" do
      create_page
      new_page
      @page.should_not be_valid
    end
    
    it "should not be valid without a unique slug" do
      create_page
      new_page({ :name => 'Another page', :slug => 'page' })
      @page.should_not be_valid
    end
  end
  
  describe "on create" do
    it "should create slug from lowercase_underscored name" do
      create_page
      @page.slug.should == 'page'
    end

    it "should not create slug from lowercase_underscored name if alternative slug is provided" do
      create_page({ :slug => "another_slug" })
      @page.slug.should == 'another_slug'
    end
    
    it "should serialize the content fields attribute as a Hash" do
      content = { :main => '<p>Main content</p>', :sidebar => '<p>Sidebar content</p>' }
      page = create_page({ :content => content })
      page.content.class.should == Hash
      page.content[:main].should == '<p>Main content</p>'
    end
  end
end
