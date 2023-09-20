class ErrorSerializer
  def initialize(error)
    @error = error
  end

  def serialize_not_found
    {
      errors: [
        {
          status: 404,
          message: "Invalid request. Please try again."
        }
      ]
    }
  end

  def serialize_bad_request
    {
      errors: [
        {
          status: 400,
          message: "Invalid request. Please try again."
        }
      ]
    }
  end
end