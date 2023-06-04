class ErrorSerializer

  def initialize(error_object)
    @error_object = error_object
  end

  def user_not_found_serialized_json
    {
      errors: [
        {
          detail: @error_object,
        }
      ]
    }
  end
end