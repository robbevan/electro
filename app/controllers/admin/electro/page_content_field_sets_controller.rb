class Admin::Electro::PageContentFieldSetsController < ApplicationController
  # GET /admin/page_content_field_sets
  def index
    @page_content_field_sets = PageContentFieldSet.find(:all)
  end

  # GET /admin/page_content_field_set/new
  def new
    @page_content_field_set = PageContentFieldSet.new
  end

  # POST /admin/page_content_field_sets
  def create
    @page_content_field_set = PageContentFieldSet.new(params[:page_content_field_set])
    if @page_content_field_set.save
      flash[:notice] = 'Page content field set was created successfully'
      redirect_to(admin_page_content_field_sets_url)
    else
      render :action => 'new'
    end
  end

  # GET /admin/page_content_field_sets/:id/edit
  def edit
    @page_content_field_set = PageContentFieldSet.find(params[:id])
  end

  # PUT /admin/page_content_field_sets/:id
  def update
    @page_content_field_set = PageContentFieldSet.find(params[:id])
    if @page_content_field_set.update_attributes(params[:page_content_field_set])
      flash[:notice] = 'Page content field set was updated successfully'
      redirect_to(admin_page_content_field_sets_url)
    else
      render :action => 'edit'
    end
  end

  # DELETE /admin/page_content_field_sets/:id
  def destroy
    @page_content_field_set = PageContentFieldSet.find(params[:id])
    @page_content_field_set.destroy
    flash[:notice] = 'Page content field set was deleted successfully'
    redirect_to admin_page_content_field_sets_url
  end
end