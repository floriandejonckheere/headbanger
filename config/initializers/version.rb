##
# Headbanger
#
module Headbanger
  # Application version
  VERSION_MAJOR = 0
  VERSION_MINOR = 1
  VERSION_PATCH = 0

  if Rails.env.production?
    VERSION = "#{VERSION_MAJOR}.#{VERSION_MINOR}.#{VERSION_PATCH}"
  else
    VERSION = "#{VERSION_MAJOR}.#{VERSION_MINOR}.#{VERSION_PATCH}-dev"
  end

  # Graph format version
  GRAPH_VERSION = 1
end
