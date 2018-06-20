# frozen_string_literal: true

require_relative "#{Rails.root}/lib/auth/guardian"

class ApplicationController < ActionController::API
  include Guardian

  rescue_from ActiveRecord::RecordNotFound do |_|
    render status: :not_found
  end

  rescue_from ActiveRecord::RecordInvalid do |error|
    render json: { error_human: error.message.split(':').second.strip }, status: :bad_request
  end

  rescue_from RailsParam::Param::InvalidParameterError do |error|
    render json: { error_human: error }, status: :bad_request
  end

  rescue_from Guardian::Unauthenticated do |error|
    render json: { error_human: error }, status: :unauthorized
  end

  rescue_from Guardian::Unauthorized do |error|
    render json: { error_human: error }, status: :forbidden
  end
end
