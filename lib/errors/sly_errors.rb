module SlyErrors


  class StateError < RuntimeError; end
  class ParameterError < RuntimeError; end
  class AuthorizationError < RuntimeError; end
end