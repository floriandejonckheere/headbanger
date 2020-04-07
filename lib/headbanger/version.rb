# frozen_string_literal: true

module Headbanger
  module Version
    MAJOR = 0
    MINOR = 1
    PATCH = 0
    PRE   = nil

    VERSION = [MAJOR, MINOR, PATCH].compact.join(".")

    STRING = [VERSION, PRE].compact.join("-")
  end

  VERSION = Headbanger::Version::STRING
end
