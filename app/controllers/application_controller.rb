class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def markdown_renderer
    HTML::Pipeline.new([
      HTML::Pipeline::MarkdownFilter,
      HTML::Pipeline::SanitizationFilter,
      HTML::Pipeline::SyntaxHighlightFilter
    ], gfm: true)
  end

  private

  def user_not_authorized
    flash[:alert] = "Brak uprawnień"
    redirect_to(request.referrer || root_path)
  end
end
