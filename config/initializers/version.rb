##
# Headbanger
#
module Headbanger
  # Application version
  VERSION_MAJOR = 0
  VERSION_MINOR = 2
  VERSION_PATCH = 0

  # App version
  VERSION = "#{VERSION_MAJOR}.#{VERSION_MINOR}.#{VERSION_PATCH}"

  # Write package.json
  hash = JSON.parse File.read(Rails.root.join('package.json'))

  hash['version'] = VERSION
  file = File.new Rails.root.join('package.json'), 'w'
  file.write JSON::pretty_generate hash
  file.close
end
