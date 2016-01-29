require 'fileutils'

if Rails.env.development?
  cache_path = Rails.root.join('tmp/cache/assets/development')
  FileUtils.rm_rf(cache_path)

  listener = Listen.to(Rails.root.join('app/assets/templates')) do |modified, added, removed|
    # clearing cache
    FileUtils.rm_rf(cache_path)
  end
  listener.start
end
