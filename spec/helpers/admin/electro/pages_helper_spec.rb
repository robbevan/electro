require 'spec/spec_helper'

describe Admin::Electro::PagesHelper do

  describe "#content_fields(page)" do
    before(:each) do
      @page = mock_model(Page)
    end

    context "when the Page content is not a Hash and the Page has no content fields" do
      it "should render a single textarea for the page content" do
        @page.stub!(:content).and_return("<p>Main content</p>")
        @page.stub!(:content_fields).and_return(nil)
        content = helper.content_fields(@page)
        content.should have_tag("textarea[name='page[content]']")
      end
    end

    context "when the Page content is a Hash and and the Page has matching content fields" do
      it "should render a textarea for each content field" do
        @page.stub!(:content).and_return({ :main => "<p>Main content</p>", :sidebar => "<p>Sidebar content</p>" })
        @page.stub!(:content_fields).and_return({ :main => 'text_area', :sidebar => 'text_area' })
        content = helper.content_fields(@page)
        content.should have_tag("textarea[name='content[main]']")
        content.should have_tag("textarea[name='content[sidebar]']")
      end
    end
  end
end
