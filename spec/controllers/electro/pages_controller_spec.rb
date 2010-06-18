require 'spec/spec_helper'

describe Electro::PagesController do

  describe "GET /show" do
    before(:each) do
      @page = mock_model(Page, :content => { :body => 'body' })
      @page.stub!(:title).and_return('title')
      @page.stub!(:description).and_return('description')
      Page.stub!(:find).and_return(@page)
    end
    
    describe "with page :name" do
      def do_get
        get :show, :name => ['name']
      end

      it "should find the Page" do
        Page.should_receive(:find).and_return(@page)
        do_get
      end

      it "should assign the Page for the view" do
        do_get
        assigns[:page].should == @page
      end

      it "should assign the Page's meta for the view" do
        do_get
        assigns[:page_title].should == @page.title
        assigns[:page_description].should == @page.description
      end
      
      context "if a :name template exists" do
        it "should render the :name template" do
          controller.stub!(:template_exists? => true)
          do_get
          response.should render_template('name')
        end
      end
      
      context "if no :name template exists" do
        it "should assign the Page's content for the view" do
          do_get
          assigns[:content].should == @page.content
        end

        it "should render the show template" do
          do_get
          response.should render_template('show')
        end
      end
    end

    describe "with page :id" do
      def do_get
        get :show, :id => "1"
      end

      it "should find the Page" do
        Page.should_receive(:find).and_return(@page)
        do_get
      end

      it "should render the show template" do
        do_get
        response.should render_template('show')
      end
    end

    describe "with :id of a non-existant page" do
      before(:each) do
        Page.stub!(:find).and_return(nil)
      end
      
      def do_get
        get :show, :id => "0"
      end

      it "should not find the Page" do
        Page.should_receive(:find).and_return(nil)
        do_get
      end

      it "should not assign the Page's meta for the view" do
        do_get
        assigns[:page_title].should be_nil
        assigns[:page_description].should be_nil
      end

      it "should render the 404 page" do
        do_get
        response.should render_template("#{RAILS_ROOT}/public/404.html")
      end

      it "should return a status code of 404" do
        do_get
        response.should be_missing
      end
    end
  end

end