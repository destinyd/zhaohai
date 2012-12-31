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

  def render_field record,attr_name
    if record.send(attr_name).blank?
      ''
    else 
      render_field_with_dl dt_field_name(record,attr_name),
        dd_field(record,attr_name)
    end
  end

  def dt_field_name record,attr_name
    content_tag(:dt,
                i18n_field_name(record,attr_name))
  end

  def i18n_field_name record,attr_name
    record.class.human_attribute_name(attr_name)
  end

  def dd_field record,attr_name
    content_tag(:dd,record.send(attr_name))
  end

  def dt content
    content_tag(:dt,content)
  end

  def dd content
    content_tag(:dd,content)
  end

  def render_field_with_dl dt,dd=nil,&block
    content_tag :dl,class:'dl-horizontal' do
      [
        self.dt(dt),
        self.dd(dd.blank? ? capture(&block) : dd)
      ].join.html_safe
    end unless dd.blank? and !block
  end

  def render_dl dt,dd=nil,&block
    content_tag :dl do
      [
        dt,
        dd.blank? ? capture(&block) : dd
      ].join.html_safe
    end unless dd.blank? and !block
  end


  def labels(p)
    t("labels.#{p}")
  end
end
