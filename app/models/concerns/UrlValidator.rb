require 'uri'

class UrlValidator < ActiveModel::Validator
  def validate(record)
    begin
      URI.parse(record.full_url)
    rescue URI::InvalidURIError
      record.errors[:base] << "Invalid URL format"
    end

  end
end