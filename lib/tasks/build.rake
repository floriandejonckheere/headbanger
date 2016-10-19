namespace :build do
  desc 'Build docker image'
  task :docker => :environment do
    `docker build -t headbanger/headbanger:#{Headbanger::VERSION} .`
  end
end
