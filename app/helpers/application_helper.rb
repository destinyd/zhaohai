module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  def p_field record,attr_name
    if record.send(attr_name).blank?
      ''
    else 
      content = "<p><b>#{record.class.human_attribute_name(attr_name)}:</b> #{record.send(attr_name)} </p>"
      raw content
    end
  end


end
