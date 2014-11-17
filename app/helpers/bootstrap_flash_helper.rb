module BootstrapFlashHelper
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
             end
      if message
        if message.is_a? Array
          message.each do |m|
            divs << content_tag(:div, '<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>'.html_safe + m,
                                class: "alert alert-#{type} alert-dismissible", role: "alert")
          end
        else
          divs << content_tag(:div, '<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>'.html_safe + message,
                              class: "alert alert-#{type} alert-dismissible", role: "alert")
        end
      end
    end
    divs.join("\n").html_safe
  end
end
