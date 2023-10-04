module JavascriptHelper

  def behavior(selector, function=nil, &block)
    @behaviors ||= []
    function = capture_haml(&block) if function.nil?
    @behaviors << [selector, function]
    nil
  end

  def emit_behaviors
    s = ""
    if @behaviors && !@behaviors.empty?
      s += "Event.onReady(function() {"
      #tab_up
      s += "Event.addBehavior({"
      #tab_up
      s += @behaviors.map { |b| "'#{ b[0] }': #{ b[1] }" }.join(",\n")
      #tab_down
      s += "})"
      #tab_down
      s += "})"
    end
    s.html_safe
  end

  def js_toggle_selector(element_id, my_element=nil)
    behavior "##{ element_id }", "Shopfixa.ToggleSelector"
  end

  def js_toggle(element_id, show_element, hide_element=nil)
    behavior "##{ element_id }", "Shopfixa.Toggle('#{show_element}', '#{hide_element||element_id}')"
  end
  
  def js_filter_selector(selector)
    behavior "#{selector}", "Shopfixa.FilterSelector"
  end
  
  def js_row_details_toggle(selector, row_prefix, detail_prefix)
    behavior "#{selector}", "Shopfixa.RowDetailsToggle('#{row_prefix}', '#{detail_prefix}')"
  end
  
  def js_check_toggle(id, element)
    behavior "##{id}", "Shopfixa.CheckToggle('#{element}')"
  end
  
end
