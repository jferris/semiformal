module Semiformal
  # Raised when attempting to parse or generate an input for an input that
  # can't be accepted.
  #
  # See Resource#accept.
  class UnacceptableInput < StandardError
  end
end
