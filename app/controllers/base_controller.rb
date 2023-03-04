# frozen_string_literal: true

class BaseController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate

  private

  def authenticate
    authed = authenticate_with_http_token do |token, _options|
      token == ENV['AUTH_TOKEN']
    end
    render json: { error: 'HTTP Token: Access Denied.' }, status: :unauthorized unless authed
  end
end
