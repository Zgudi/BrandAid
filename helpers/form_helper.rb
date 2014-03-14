module FormHelpers
  def input_error(object, attribute)
    error = ""
    unless object.nil?
      errors = object.errors.messages
      if defined?(errors[:"#{attribute}"]) && errors[:"#{attribute}"].present?
        error = "<span class='help-inline text-danger'>#{errors[:"#{attribute}"].first.to_s}</span>"
      end
    end
    error.html_safe
  end

  def input_value(object, attribute, id=nil, sub_attribute=nil, sub_id=nil)
    value = ""
    if object.attributes["#{attribute}"].present?
      if id.nil?
        value = object.attributes["#{attribute}"]
      else
        if sub_attribute.nil?
          value = object.attributes["#{attribute}"]["#{id}"] if object.attributes["#{attribute}"]["#{id}"].present?
        else
          if sub_id.nil?
            value = object.attributes["#{attribute}"]["#{id}"]["#{sub_attribute}"] if object.attributes["#{attribute}"]["#{id}"]["#{sub_attribute}"].present?
          else
            value = object.attributes["#{attribute}"]["#{id}"]["#{sub_attribute}"]["#{sub_id}"] if object.attributes["#{attribute}"]["#{id}"]["#{sub_attribute}"]["#{sub_id}"].present?
          end
        end
      end
    end
    value
  end

  def capitalize_words(sentence)
    sentence.split("_").map(&:capitalize).join(" ")
  end

  def input_color(object, attribute)
    input_class = ""
    unless object.nil?
      errors = object.errors.messages
      if defined?(errors[:"#{attribute}"]) && errors[:"#{attribute}"].present?
        input_class = "has-error"
      else
        input_class = "has-success"
      end
    end
    input_class
  end

  def form_input(object,  attribute, options ={})
    input =  "<div class=\"form-group #{input_color(object, attribute)}\">"
    input += "<label class=\"col-lg-4 control-label\" for=\"#{name(object)}_#{attribute}\"> #{capitalize_words(attribute)}</label>"
    input += "<div class=\"col-lg-6\">"
    input += "<input id=\"#{name(object)}_#{attribute}\" class=\"form-control\" autofocus = \"autofocus\" name = \"#{name(object)}[#{attribute}]\" #{options[:password] ? "type=\"password\"" : "type = \"text\""} value = \"#{input_value(object, attribute)}\"/>"
    input += input_error(object, attribute)
    input += "</div></div>"
    input.html_safe
  end

  def form_optional_input(object, attribute, id, options ={})
    input =  "<div id=\"group_#{name(object)}_#{attribute}_#{id}\" class=\"form-group #{input_color(object, "#{attribute}_#{id}")}\">"
    input += "<label class=\"col-lg-4 control-label\" for=\"#{name(object)}_#{attribute}_#{id}\"> #{capitalize_words(attribute)}</label>"
    input += "<div class=\"col-lg-3\">"
    input += "<input id=\"input_#{name(object)}_#{attribute}_#{id}\" class=\"form-control#{options[:pick_a_color] ? " pick-a-color" : ""}\" autofocus = \"autofocus\" name = \"#{name(object)}[#{attribute}][#{id}]\" type = \"text\" value = \"#{input_value(object, attribute, id)}\"/>"
    input += input_error(object, "#{attribute}_#{id}")
    input += "</div>"
    input += "<div id=\"close_#{name(object)}_#{attribute}_#{id}\" class=\"btn btn-danger btn-xs remove\" >X</div>"
    input += "</div>"
    input.html_safe
  end

  def form_nested_input(object, attribute, id, sub_attribute)
    input =  "<div id=\"group_#{name(object)}_#{attribute}_#{id}_#{sub_attribute}\" class=\"form-group #{input_color(object, "#{attribute}_#{id}_#{sub_attribute}")}\">"
    input += "<label class=\"col-lg-4 control-label\" for=\"#{name(object)}_#{attribute}_#{id}\"> #{capitalize_words(sub_attribute)}</label>"
    input += "<div class=\"col-lg-6\">"
    input += "<input id=\"input_#{name(object)}_#{attribute}_#{id}_#{sub_attribute}\" class=\"form-control\" autofocus = \"autofocus\" name = \"#{name(object)}[#{attribute}][#{id}][#{sub_attribute}]\" type = \"text\" value = \"#{input_value(object, attribute, id, sub_attribute)}\"/>"
    input += input_error(object, "#{attribute}_#{id}_#{sub_attribute}")
    input += "</div></div>"
    input.html_safe
  end

  def form_nested_optional_select(object, attribute, id, sub_attribute,  sub_id)
    input =  "<div id=\"group_#{name(object)}_#{attribute}_#{id}_#{sub_attribute}_#{sub_id}\" class=\"form-group #{input_color(object, "#{attribute}_#{id}_#{sub_attribute}_#{sub_id}")}\">"
    input += "<label class=\"col-lg-4 control-label\" for=\"#{name(object)}_#{attribute}_#{id}_#{sub_attribute}_#{sub_id}\"> #{capitalize_words(sub_attribute)}</label>"
    input += "<div class=\"col-lg-3\">"
    input += "<select id=\"select_#{name(object)}_#{attribute}_#{id}_#{sub_attribute}_#{sub_id}\" class=\"form-control\" name = \"#{name(object)}[#{attribute}][#{id}][#{sub_attribute}][#{sub_id}]\">"
    value = input_value(object, attribute, id, sub_attribute, sub_id)
    safe_web_fonts.each do |font|
      input += "<option value=\"#{font}\" #{value.to_s == font.to_s ? "selected=\"selected\"" : ""}>#{font}</option>"
    end
    input += "</select>"
    input += input_error(object, "#{attribute}_#{id}_#{sub_attribute}_#{sub_id}")
    input += "</div>"
    input += "<div id=\"close_#{name(object)}_#{attribute}_#{id}_#{sub_attribute}_#{sub_id}\" class=\"btn btn-danger btn-xs remove\" >X</div>"
    input += "</div>"
    input.html_safe
  end

  def form_textarea(object, attribute)
    input =  "<div class=\"form-group #{input_color(object, attribute)}\">"
    input += "<label class=\"col-lg-4 control-label\" for=\"#{name(object)}_#{attribute}\"> #{capitalize_words(attribute)}</label>"
    input += "<div class=\"col-lg-6\">"
    input += "<textarea id=\"#{name(object)}_#{attribute}\" class=\"form-control\" name = \"#{name(object)}[#{attribute}]\" >"
    input += input_value(object, attribute)
    input += "</textarea>"
    input += input_error(object, attribute)
    input += "</div></div>"
    input.html_safe
  end

  def form_nested_textarea(object, attribute, id, sub_attribute)
    input =  "<div class=\"form-group #{input_color(object, "#{attribute}_#{id}_#{sub_attribute}")}\">"
    input += "<label class=\"col-lg-4 control-label\" for=\"#{name(object)}_#{attribute}_#{id}_#{sub_attribute}\"> #{capitalize_words(sub_attribute)}</label>"
    input += "<div class=\"col-lg-6\">"
    input += "<textarea id=\"#{name(object)}_#{attribute}_#{id}_#{sub_attribute}\" class=\"form-control\" name = \"#{name(object)}[#{attribute}][#{id}][#{sub_attribute}]\" >"
    input += input_value(object, attribute, id, sub_attribute)
    input += "</textarea>"
    input += input_error(object, "#{attribute}_#{id}_#{sub_attribute}")
    input += "</div></div>"
    input.html_safe
  end

  def name(object)
    object.class.name.downcase
  end

  def input_id(element)
    element.keys.sort.each { |k| element[k] = element.delete k }.last.to_i + 1
  end


  def safe_web_fonts
    ["Arial", "Arial Black", "Comic Sans MS", "Courier New", "Georgia", "Helvetica Neue", "Helvetica", "Impact", "Lucida Console", "Sans Serif", "Serif", "Tahoma", "Times New Roman", "Trebuchet MS", "Verdana"]
  end
end