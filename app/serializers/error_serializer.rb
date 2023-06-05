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

  def user_invalid_attributes_serialized_json
    {
      errors: [
        {
          detail: "Validation failed: #{@error_object.full_messages.join(", ")}"
        }
      ]
    }
  end

  def nil_values_serialized_json
    kept_errors = @error_object.full_messages.delete_if { |error| error.include?("must exist")}
    {
            "errors": [
                {
                    "detail": "Validation failed: #{kept_errors.join(", ")}"
                }
            ]
        }
  end
end