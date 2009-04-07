require 'action_view/helpers/javascript_helper.rb'

class ErrorFormBuilder < ActionView::Helpers::FormBuilder
    
  #Adds error message directly inline to a form label
  #Accepts all the options normall passed to form.label as well as:
  #  :hide_errors - true if you don't want errors displayed on this label
  #  :additional_text - Will add additional text after the error message or after the label if no errors
  def label(method, text = nil, options = {})
    #Check to see if text for this label has been supplied and humanize the field name if not.
    text = text || method.to_s.humanize
    
    # Add a star if required
    text += ' <span class="req">*</span>' if options[:required_field]
    
    #Get a reference to the model object
    object = @template.instance_variable_get("@#{@object_name}")

    #Make sure we have an object and we're not told to hide errors for this label
    unless object.nil? || options[:hide_errors]
      #Check if there are any errors for this field in the model
      errors = object.errors.on(method.to_sym)
      if errors
        #Generate the label using the text as well as the error message wrapped in a span with error class
        #text += " <span class=\"error\">#{errors.is_a?(Array) ? errors.first : errors}</span>"
      end
    end
    
    #Add any additional text that might be needed on the label
    text += " #{options[:additional_text]}" if options[:additional_text]
    
    #Finally hand off to super to deal with the display of the label
    super(method, text, options)
  end
  
  def time_picker(method, options = {})
    #Get a reference to the model object
    object = @template.instance_variable_get("@#{@object_name}")
    
    text = ""
    
    text += select_hour(object.send(method), :field_name => 'stride')
    text += select_minute(object.send(method), :field_name => 'asdf')
    
    return text
  end
  
  def date_picker(method, options = {})
    #Get a reference to the model object
    object = @template.instance_variable_get("@#{@object_name}")
    
    text = ""
    
    text += "
    <span>
  		<input id=\"#{ method.to_s }-1\" name=\"request[#{ method.to_s }(2i)]\" 
  			type=\"text\" class=\"field text\" value=\"#{ object.send(method).nil? ? '' : object.send(method).month }\" size='2' maxlength='2' /> 
  		<label for=\"#{ method.to_s }-1\">MM</label>
  	</span>
  	<span>
  		<input id=\"#{ method.to_s }-2\" name=\"request[#{ method.to_s }(3i)]\" 
  			type=\"text\" class=\"field text\" value=\"#{ object.send(method).nil? ? "" : object.send(method).day }\" size='2' maxlength='2' /> 
  		<label for=\"#{ method.to_s }-2\">DD</label>
  	</span>
  	<span>
  		<input id=\"#{ method.to_s }\" name=\"request[#{ method.to_s }(1i)]\" 
  			type=\"text\" class=\"field text\" value=\"#{ object.send(method).nil? ? "" : object.send(method).year }\" size=\"4\" maxlength=\"4\" />
  		<label for=\"#{ method.to_s }\">YYYY</label>
  	</span>
  	<span id=\"cal_#{ method.to_s }\">
  		<img id=\"pick_#{ method.to_s }\" class=\"datepicker\" src=\"/images/icons/calendar.png\" alt=\"Pick a date.\" />
  	</span>
  	<script type=\"text/javascript\">
  	Calendar.setup({
  	inputField : \"#{ method.to_s }\",
  	displayArea  : \"cal_#{ method.to_s }\",
  	button : \"pick_#{ method.to_s }\",
  	ifFormat : \"%B %e, %Y\",
  	onSelect : selectDate
  	});
  	</script>
  	"
  	return text
  end
  
  def tab_button(page, text, fields = [], options = {})
    object = @template.instance_variable_get("@#{@object_name}")
    
    have_errors = false
    
    # Check for errors in any of the fields specified
    unless object.nil? || options[:hide_errors]
      fields.each do |field|        
        errors = object.errors.on(field.to_sym)
        if errors
          have_errors = true
        end
      end
    end
    
    # text = link_to_function page.humanize, "switch_tab('page_#{page}');"
    if options[:current] == true
      classname = "tab currtab"
    else
      classname = "tab"
    end

    
    newtext = "<span class=\"#{classname}\" id=\"#{"tab_page_" + page}\">"
    if have_errors
      newtext += "<span class=\"errortab\">" + text + "</span>"
    else
      newtext += text
    end
    # text +=  '<span class="req">*</span>' if have_errors
    newtext += "</span>\n"
    return newtext
    
  end
  
  def group_start(fields = [], options = {})
    object = @template.instance_variable_get("@#{@object_name}")
    
    css_class = "    "  if options[:position] == "full"
    css_class = "leftHalf     "  if options[:position] == "left"    
    css_class = "rightHalf     "  if options[:position] == "right"
    css_class = "section    "  if options[:section] == true
    
    have_errors = false
    
    # Check for errors in any of the fields specified
    unless object.nil? || options[:hide_errors]
      fields.each do |field|
        
        errors = object.errors.on(field.to_sym)
        if errors
          have_errors = true
        end
      end
    end
    
    css_class += "error" if have_errors
        
    return "<li class=\"#{css_class}\" id=\"#{ options[:id] }\" style=\"#{ options[:style] }\">"
        
  end
  
  # Closes a form_group
  def group_end()
    return "</li>\n"
  end
  
end

#<input id="request_assembly_time1_1i" name="request[assembly_time1(1i)]" type="hidden" value="2009" />
#<input id="request_assembly_time1_2i" name="request[assembly_time1(2i)]" type="hidden" value="4" />
#<input id="request_assembly_time1_3i" name="request[assembly_time1(3i)]" type="hidden" value="6" />
#<select id="request_assembly_time1_4i" name="request[assembly_time1(4i)]">
#<option value="00">00</option>
#<option value="01">01</option>
#
#</select>
# : <select id="request_assembly_time1_5i" name="request[assembly_time1(5i)]">
#<option selected="selected" value="00">00</option>
#<option value="15">15</option>
#<option value="30">30</option>
#<option value="45">45</option>
#</select>

