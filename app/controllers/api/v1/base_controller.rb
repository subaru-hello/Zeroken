# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      include Api::ExceptionHandler
      include ActionController::HttpAuthentication::Token::ControllerMethods

      protected

      def authenticate
        authenticate_or_request_with_http_token do |token, _options|
          @authenticate ||= ApiKey.active.find_by(access_token: token)&.user
        end
      end

      def authenticated_user
        @authenticate
      end

      def set_access_token!(user)
        api_key = user.activate_api_key!
        response.headers['AccessToken'] = api_key.access_token
      end

      private

      def form_authenticity_token; end
    end
  end
end
