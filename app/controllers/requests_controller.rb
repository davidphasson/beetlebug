class RequestsController < ApplicationController
  before_filter :find_request, :only => %w(show edit update destroy email)

  def index
    @requests = Request.all
  end 

  def show
  end 

  def new 
    @request = Request.new
    # This needs to go somewhere else
    @request.school_phys_address_same = true
  end 

  # This is mostly for e-mail testing
  def email
    Mailman.deliver_request_notification(@request)    
  end

  def edit
  end 

  def create
    time_methods = [:assembly_time1, :assembly_time2, :assembly_time3, :lunch_end, :lunch_start]
    tries = 0
    begin
      #logger.error(params.inspect + "\n\n")
      time_methods.each do |t|
        # If they did the hour, but forgot the minute, set it to zero
        if params[t] && ! params[t][:hour].blank? && params[t][:minute].blank?
          params[t][:minute] = "0"
        end
        # Set the real param in the request section only if they specified a time
        if params[t] && ! params[t][:hour].blank? && ! params[t][:minute].blank?
          params[:request][t] = "#{params[t][:hour]}:#{params[t][:minute]}:00"
        else
          params[:request][t] = nil
        end
      end
      @request = Request.new(params[:request])
    # Trap multi_errors from dates and log them prettierly
    rescue => multi_errors
      logger.error("\n\nTrap, Attempt: " + tries.to_s + "\n")
      multi_errors.errors.each do |assign_error|
        logger.error("***\n#{assign_error.exception.class} (#{assign_error.exception.message}):\n   " +
          clean_backtrace(assign_error.exception).join("\n    ") + "\n" +
          "Attribute: #{assign_error.attribute}\n")
#        a = assign_error.attribute
#        if time_methods.include?(a.to_sym)
#          # If we see a time specified, add current date and retry, else nil it out
#          if(!  (params[:request][ a.to_s + "(4i)" ].nil? || params[:request][ a.to_s + "(5i)" ].nil? ) )
#            logger.error("Setting date on #{a} and retrying")
#            b = Date.today            
#            params[:request][ a.to_s + "(1i)" ] = b.year
#            params[:request][ a.to_s + "(2i)" ] = b.month
#            params[:request][ a.to_s + "(3i)" ] = b.day
#          else
#            logger.error("Deleting #{a} from params and retrying")
#            params[:request].delete( a.to_s + "(1i)" )
#            params[:request].delete( a.to_s + "(2i)" )
#            params[:request].delete( a.to_s + "(3i)" )
#            params[:request].delete( a.to_s + "(4i)" )
#            params[:request].delete( a.to_s + "(5i)" )
#          end
#        end      
      end
      logger.fatal("#{multi_errors.class} (#{multi_errors.message}):\n" + 
        clean_backtrace(multi_errors).join("\n    ") + "\n")
      
      # Retry once in case the code cleaned it up, else raise
#      tries += 1
#      unless tries < 2
#        logger.error("* Won't retry anymore *\n")
        raise
#      end
#      retry
    else
      if @request.save
        flash[:notice] = 'Request was successfully created.'
        Mailman.deliver_request_notification(@request)
        # redirect_to(@request)
        redirect_to "http://www.amandahammond.com/beetlebug/"
      else
        flash.now[:warning] = 'There was a problem creating the request.'
        render :action => "new"
      end      
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
