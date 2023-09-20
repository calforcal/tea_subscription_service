class ErrorSerializer
  def initialize(error)
    @error = error
  end

  def serialize_json
    {
      errors: [
        {
          status: 404,
          message: "Invalid request. Please try again."
        }
      ]
    }
  end
end