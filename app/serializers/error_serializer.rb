class ErrorSerializer

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

  def self.no_record_found
    {
      data: {}
    }
  end

  def self.no_records_found
    {
      data: []
    }
  end

end
