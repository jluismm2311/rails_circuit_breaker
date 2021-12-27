# frozen_string_literal: true

require './lib/jsend'

module Api
  module V1
    class CircuitBreakerController < ActionController::API
      around_action :stoplight

      rescue_from Stoplight::Error::RedLight, with: :handle_stopligth_errors

      def test_method
        if(params[:red_flag] == 'true')
          raise StandardError
        end
        render json: Jsend.success(data: {}), status: :ok
      end

      private

      def stoplight(&block)
        @config = Rails.application.config_for(:config)[:circuit_breaker]
        Stoplight(@config[:name], &block)
          .with_cool_off_time(@config[:cool_off_time])
          .with_threshold(@config[:threshold])
          .with_error_handler do |error, handle|

          handle.call(error)
        end
          .run
      end

      def handle_stopligth_errors(exception)
        render json: Jsend.error(message: 'renapo service is unavailable error message due to circuit-breaker',
                                 code: 'circuit_breaker_error'), status: :service_unavailable
      end
    end
  end
end