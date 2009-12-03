class Admin::Electro::PagesController < ApplicationController
  # GET /admin/pages
  def index
    if params[:q]
      @pages = search(params[:q])
    else
      @pages = Page.paginate(:all, :order => 'name ASC', :page => params[:page])
    end
  end

  # GET /admin/page/new
  def new
    @page = Page.new
    @page_content_field_set = PageContentFieldSet.find_by_name("Default") || nil
    @page.page_content_field_set = @page_content_field_set
  end

  # POST /admin/pages
  def create
    @page = Page.new(params[:page])
    if @page.save
      flash[:notice] = 'Page was created successfully'
      redirect_to admin_pages_url
    else
      render :action => 'new'
    end
  end

  # GET /admin/pages/:id/edit
  def edit
    @page = Page.find(params[:id])
  end

  # PUT /admin/pages/:id
  def update
    @page = Page.find(params[:id])
    attributes = params[:page]
    attributes.merge!({:content => params[:content]}) if params[:content]
    if @page.update_attributes(attributes)
      flash[:notice] = 'Page was updated successfully'
      redirect_to admin_pages_url
    else
      render :action => 'edit'
    end
  end

  # DELETE /admin/pages/:id
  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    flash[:notice] = 'Page was deleted successfully'
    redirect_to admin_pages_url
  end
  
  private
  
    def search(q)
      sql = "id LIKE ? OR name LIKE ? OR slug LIKE ?"
      Page.find(:all, :conditions => [sql, "%#{q}%", "%#{q}%", "%#{q}%"])
    end
end