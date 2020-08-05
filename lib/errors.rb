class Errors

	def initialize
	end

	def handle_errors(response)
		if [200, 201].include? response.code
			return
		raise BadRequest.new()
		end

	end
end


class BadRequest < StandardError
	def initialize(msg='Bad Request. Please try again')
		super
	end
end

class TimeOut < StandardError
	def initialize(msg='The request got timed out.')
		super
	end
end