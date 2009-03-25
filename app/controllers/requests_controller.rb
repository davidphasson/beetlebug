class RequestsController < ApplicationController
  before_filter :find_request, :only => %w(show edit update destroy)

  def index
    @requests = Request.all
  end 

  def show
  end 

  def new 
    @request = Request.new
  end 

  def edit
  end 

  def create
    @request = Request.new(params[:request])
    if @request.save
      flash[:notice] = 'Request was successfully created.'
      redirect_to(@request)
    else
      flash.now[:warning] = 'There was a problem creating the request.'
      render :action => "new"
    end 
  end 

  def update
    if @request.update_attributes(params[:request])
      flash[:notice] = 'Request was successfully updated.'
      redirect_to(@request)
      else
        flash.now[:warning] = 'There was a problem updating the request.'
        render :action => "edit"
      end
    end

    def destroy
      @request.destroy
      flash[:notice] = "The request was deleted."
      redirect_to(requests_url)
    end

    protected
    
    def find_request
      @request = Request.find(params[:id])
    end


end
