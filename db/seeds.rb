require 'yaml'

puts 'Seeding database'

genres = YAML.load_file Rails.root.join('db', 'seeds', 'genres.yml')
genres.keys.each do |genre|
  Graph::Genre.create(:name => genres[genre]['name'])
end

puts 'Done seeding database'
