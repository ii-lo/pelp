module ApplicationHelper
  # change the default link renderer for will_paginate
  def will_paginate(collection_or_options = nil, options = {})
    if collection_or_options.is_a? Hash
      options, collection_or_options = collection_or_options, nil
    end
    unless options[:renderer]
      options = options.merge renderer: BootstrapPagination::Rails
    end
    super(*[collection_or_options, options].compact)
  end

  # Modified version of javascript_tag
  # This one does not embrace everything in CDATA section.
  def javascript_tag_no_cdata(content_or_options_with_block = nil, html_options = {}, &block)
    content =
        if block_given?
          html_options = content_or_options_with_block if content_or_options_with_block.is_a?(Hash)
          capture(&block)
        else
          content_or_options_with_block
        end

    content_tag(:script, content, html_options)
  end
end
