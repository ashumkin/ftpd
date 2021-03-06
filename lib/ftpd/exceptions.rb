module Ftpd

  # All errors (purposefully) generated by this library driver from
  # this class.

  # Any error that send a reply to the client raises a FtpServerError.
  # The message is the text to send (e.g. "Syntax error") and the code
  # is the FTP response code to send (e.g. "502"). This is typically not
  # raised directly, but using the Error mixin.

  class FtpServerError < StandardError
    attr_reader :code

    def initialize(message, code)
      @code = code
      raise ArgumentError, "Invalid response code" unless valid_response_code?

      super(message)
    end

    def message_with_code
      "#{code} #{message}"
    end

    private
    def valid_response_code?
      (400..599).cover?(code)
    end
  end

  # A permanent file system error.  The file isn't there, etc.

  class PermanentFileSystemError < FtpServerError
    def initialize(message, code = 550)
      super
    end

    private
    def valid_response_code?
      (550..559).cover?(code)
    end
  end

  # A transient file system error.  The file is busy, etc.

  class TransientFileSystemError < FtpServerError
    def initialize(message, code = 450)
      super
    end

    private
    def valid_response_code?
      (450..459).cover?(code)
    end
  end

  # A permanent file system error.  Deprecated; use
  # PermanentFileSystemError instead.

  class FileSystemError < PermanentFileSystemError ; end

end
