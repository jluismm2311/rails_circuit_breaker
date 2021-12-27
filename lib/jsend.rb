# frozen_string_literal: true

class Jsend
  class << self
    def success(data: nil)
      {
        status: 'success',
        code: 'ok',
        message: 'ok',
        data: data
      }
    end

    def failure(message:, code: nil, data: nil)
      code ||= 'bad_request'
      {
        status: 'fail',
        code: code&.downcase,
        message: message,
        data: data
      }
    end

    def error(message:, code: nil, data: nil)
      code ||= 'INTERNAL_SERVER_ERROR'
      {
        status: 'error',
        code: code&.upcase,
        message: message,
        data: data
      }
    end
  end
end
