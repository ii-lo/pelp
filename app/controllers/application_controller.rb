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

  def after_sign_in_path_for(resource)
    return '/admin' if Admin === resource
    super
  end

  private

  def user_not_authorized
    flash[:alert] = "Brak uprawnień"
    redirect_to(request.referrer || root_path)
  end
end
