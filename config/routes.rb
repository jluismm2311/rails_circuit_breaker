# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'circuit_breaker/', to: 'circuit_breaker#test_method'
    end
  end
end

