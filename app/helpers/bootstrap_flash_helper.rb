module BootstrapFlashHelper
  CLOSE_BUTTON_HTML = '<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Zamknij</span></button>'.html_safe

  def bootstrap_flash
    divs = []

    flash.each do |type, message|
      type = case type.to_sym
               when :notice
                 :success
               when :alert
                 :warning
               when :info
                 :info
               when :error
                 :danger
               else
                 :info
             end
      if message
        Array.wrap(message).each do |msg|
          divs << content_tag(:div, CLOSE_BUTTON_HTML + msg,
                              class: "alert alert-#{type} alert-dismissible", role: 'alert')
        end
      end
    end

    if divs.empty?
      ''
    else
      content_tag(:div, content_tag(:div, divs.join("\n").html_safe, class: 'col-xs-12'), class: 'row')
    end
  end
end
