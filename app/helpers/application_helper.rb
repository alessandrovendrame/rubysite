# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def friendly_timestamp(t)
    # TODO: controllare confronto tra date e il fuso orario
    # TODO: aggiungere 'Ieri alle xx:xx'
    Date.today.strftime("%d/%m/%y") == t.strftime("%d/%m/%y") ? t.strftime("<span class='highlight'>Oggi alle %H:%M</span>").html_safe : 
      Date.yesterday.strftime("%d/%m/%y") == t.strftime("%d/%m/%y") ? t.strftime("<span>Ieri alle %H:%M</span>").html_safe : 
      t.strftime("%d/%m/%y %H:%M")
  end
  
  def friendly_datestamp(t)
    # TODO: controllare confronto tra date e il fuso orario
    # TODO: aggiungere 'Ieri alle xx:xx'
    Date.today.strftime("%d/%m/%y") == t.strftime("%d/%m/%y") ? t.strftime("<span class='highlight'>Oggi</span>").html_safe : 
      Date.yesterday.strftime("%d/%m/%y") == t.strftime("%d/%m/%y") ? t.strftime("<span>Ieri</span>").html_safe : 
      t.strftime("%d/%m/%y")
  end
  
  def icon(name, options={})
    options[:src] = image_path("layout/#{ name }.png")
    options[:alt] ||= name
    tag("img", options)
  end
  
  def render_collection(collection, partial, &block)
    if collection.nil? || collection.empty?
      # alt_text = capture_haml(&block)
      # puts alt_text
    else
      render :partial => partial, :collection => collection
    end
  end
  
  def create_or_cancel(url_or_function, label=" Create ")
    if url_or_function.match(/^\{.+\}/) then
      url = "#"
      function = url_or_function
    else
      url = url_or_function
      function = ""
    end
    content_tag(:div, link_to(icon("cross") + " Annulla", url, :onclick => function, :style => 'float: right;') + content_tag(:button, icon("tick") + " " + label, :type => "submit"), :class => "form_block_button buttons highlight") + "<br style='clear: both;'/>"
  end
  
end
