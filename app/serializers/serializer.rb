class Serializer

  def self.return_errors(errors)
    {
      "message": "your query could not be completed",
      "errors": errors
    }
  end

  def self.return_error(error)
    {
      "message": "your query could not be completed",
      "error": error
    }
  end

end
