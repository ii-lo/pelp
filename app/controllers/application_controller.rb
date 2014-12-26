class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception


  def markdown_renderer
    HTML::Pipeline.new([
      HTML::Pipeline::MarkdownFilter,
      HTML::Pipeline::SanitizationFilter,
      HTML::Pipeline::SyntaxHighlightFilter
    ], gfm: true)
  end

end
