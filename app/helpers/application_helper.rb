# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def default_content_for(name, &block)
    name = name.kind_of?(Symbol) ? ":#{name}" : name
    out = eval("yield #{name}", block.binding)
    concat(out || capture(&block))
  end
  
  # Note that page["flash-#{type}"].visual_effect(:fade) should work as well, but the jRails plugin appears buggy
  def display_flash(*flashes)
    flashes = [:notice] if flashes.empty?
    flashes.map! do |type|
      if flash[type]
        content_tag(:div, :id => "flash-#{type}", :class => "flash #{type}") do
          link_to_function(image_tag("close-flash.png"), :class => "close") { |page| page.visual_effect(:fade, "flash-#{type}") } + flash[type]
        end
      end
    end
    flashes.join
  end
end
