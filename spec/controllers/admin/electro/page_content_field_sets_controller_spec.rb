require 'spec/spec_helper'

describe Admin::Electro::PageContentFieldSetsController do

  describe "GET /index" do
    def do_get
      get :index
    end

    before(:each) do
      @page_content_field_set = mock_model(PageContentFieldSet)
      PageContentFieldSet.stub!(:find).and_return([@page_content_field_set])
    end

    it "should render the index template" do
      do_get
      response.should render_template('index')
    end

    it "should find all PageContentFieldSets" do
      PageContentFieldSet.should_receive(:find).and_return([@page_content_field_set])
      do_get
    end

    it "should assign the PageContentFieldSets for the view" do
      do_get
      assigns[:page_content_field_sets].should == [@page_content_field_set]
    end
  end

  describe "GET /new" do
    before(:each) do
      @page_content_field_set = mock_model(PageContentFieldSet)
      PageContentFieldSet.stub!(:new).and_return(@page_content_field_set)
    end
    
    def do_get
      get :new
    end
  
    it "should render the new template" do
      do_get
      response.should render_template('new')
    end
  
    it "should create a new PageContentFieldSet" do
      PageContentFieldSet.should_receive(:new).and_return(@page_content_field_set)
      do_get
    end
    
    it "should not save the PageContentFieldSet" do
      PageContentFieldSet.should_not_receive(:save)
      do_get
    end
    
    it "should assign the PageContentFieldSet for the view" do
      do_get
      assigns[:page_content_field_set].should == @page_content_field_set
    end
  end

  describe "POST /create" do
    before(:each) do
      @page_content_field_set = mock_model(PageContentFieldSet)
      @page_content_field_set.stub!(:save).and_return(true)
      PageContentFieldSet.stub!(:new).and_return(@page_content_field_set)
    end
    
    def do_post
      post :create
    end
  
    it "should create a new PageContentFieldSet" do
      PageContentFieldSet.should_receive(:new).and_return(@page_content_field_set)
      do_post
    end
  
    it "should save the PageContentFieldSet" do
      @page_content_field_set.should_receive(:save).and_return(true)
      do_post
    end
  
    it "should redirect to the index page if saved successfully" do
      do_post
      response.should redirect_to(admin_page_content_field_sets_url)
    end
  
    it "should re-render the new template if save failed" do
      @page_content_field_set.stub!(:save => false)
      do_post
      response.should render_template('new')
    end
  end

  describe "GET /edit" do
    before(:each) do
      @page_content_field_set = mock_model(PageContentFieldSet)
      PageContentFieldSet.stub!(:find).and_return(@page_content_field_set)
    end

    def do_get
      get :edit
    end
  
    it "should render the edit template" do
      do_get
      response.should render_template('edit')
    end

    it "should find the PageContentFieldSet" do
      PageContentFieldSet.should_receive(:find).and_return(@page_content_field_set)
      do_get
    end

    it "should assign the PageContentFieldSet for the view" do
      do_get
      assigns[:page_content_field_set].should == @page_content_field_set
    end
  end

  describe "PUT /update" do
    def do_put
      put :update
    end
    
    before(:each) do
      @page_content_field_set = mock_model(PageContentFieldSet)
      @page_content_field_set.stub!(:update_attributes => true)
      PageContentFieldSet.stub!(:find).and_return(@page_content_field_set)
    end

    it "should find the PageContentFieldSet" do
      PageContentFieldSet.should_receive(:find).and_return(@page_content_field_set)
      do_put
    end

    it "should update the PageContentFieldSet" do
      @page_content_field_set.should_receive(:update_attributes).and_return(true)
      do_put
    end

    it "should redirect to the index page if updated successfully" do
      do_put
      response.should redirect_to(admin_page_content_field_sets_url)
    end
  
    it "should re-render the edit template if update fails" do
      @page_content_field_set.stub!(:update_attributes => false)
      do_put
      response.should render_template('edit')
    end
  end

  describe "DELETE /destroy" do
    before(:each) do
      @page_content_field_set = mock_model(PageContentFieldSet)
      PageContentFieldSet.stub!(:find).and_return(@page_content_field_set)
      @page_content_field_set.stub!(:destroy => true)
    end
    
    def do_delete
      delete :destroy
    end
  
    it "should find the PageContentFieldSet" do
      PageContentFieldSet.should_receive(:find).and_return(@page_content_field_set)
      do_delete
    end
    
    it "should destroy the PageContentFieldSet" do
      @page_content_field_set.should_receive(:destroy)
      do_delete
    end
    
    it "should redirect to the index page" do
      do_delete
      response.should redirect_to(admin_page_content_field_sets_url)
    end
  end

end
