class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :bad_request
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found(error)
    render json: ErrorSerializer.new(error).serialize_not_found, status: :not_found
  end

  def bad_request(error)
    render json: ErrorSerializer.new(error).serialize_bad_request, status: 400
  end
end
