# Stub out paperclip during tests to speed up test suite.

module Paperclip
  def self.run cmd, params = "", expected_outcodes = 0
    case cmd
    when "identify"
      return "100x100"
    when "convert"
      return
    else
      super
    end
  end
end

class Paperclip::Attachment
  def post_process
  end
end

class Paperclip::Validators::AttachmentContentTypeValidator
  def validate_each(record, attribute, value)
  end
end