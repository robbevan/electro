require 'spec/spec_helper'

describe Electro::PagesHelper do
  before(:each) do
    @page = mock_model(Page, :name => "Page")
    Page.stub!(:find).and_return(@page)
  end
  
  
  describe "#page(name)" do
    before(:each) do
      @page.stub!(:content).and_return({ :body => "Content" })
    end
    
    it "should find the Page" do
      Page.should_receive(:find).and_return(@page)
      helper.page("Page")
    end

    it "should return the Page content" do
      helper.page("Page").should == "Content"
    end
  end

  describe "#page_content_for(key, content)" do
    context "when the Page content is a Hash and a key is specified" do
      it "should return the value for the key" do
        @page.stub!(:content).and_return({ :main => "<p>Main content</p>", :sidebar => "<p>Sidebar content</p>" })
        content = helper.page_content_for(@page.content, :main)
        content.should have_tag("p", "Main content")
      end
    end
    
    context "when the Page content is not a Hash and a key is specified" do
      it "should return nil" do
        @page.stub!(:content).and_return("<p>Content</p>")
        content = helper.page_content_for(@page.content, :main)
        content.should be_nil
      end
    end

    context "when the Page content is not a Hash and a key is specified but the default value is acceptable" do
      it "should return the default content" do
        @page.stub!(:content).and_return("<p>Content</p>")
        content = helper.page_content_for(@page.content, { :key => :main, :accept_default => true } )
        content.should have_tag("p", "Content")
      end
    end

    context "when the Page content is empty" do
      it "should return nil" do
        @page.stub!(:content).and_return(nil)
        content = helper.page_content_for(@page.content, :main)
        content.should be_nil
      end
    end
  end
end
