require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  before_action :adjust_format_for_xhr_html
  before_action :set_raven_context

  rescue_from CanCan::AccessDenied do |exception|
    if current_user
      render plain: "AccessDenied", status: :forbidden
    else
      redirect_to new_user_session_path
    end
  end

protected
  def adjust_format_for_xhr_html
    request.format = :xhrml if request.format.to_sym == :html && (request.xhr? || params[:xhr])
  end

  def ok_url_or_default(default)
    params[:ok_url] || default
  end
  helper_method :ok_url_or_default

  def set_raven_context
    Raven.user_context(id: current_user&.id)
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end

  def current_member
    nil
  end
  helper_method :current_member

  def current_project
    nil
  end
  helper_method :current_project

  def current_ability
    @current_ability ||= Ability.new { |a| a.apply_user_permissions(current_user) }
  end
end
