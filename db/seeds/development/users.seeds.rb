# frozen_string_literal: true

neo4j_transaction do
  Rails.logger.info "-- Creating users"

  rand(100..200).times do
    user = FactoryBot.create(:user)

    # Likes
    genres = Graph::Genre.all.to_a.sample(rand(1..3))
    themes = Graph::Theme.all.to_a.sample(rand(5..10))

    groups = [genres.map(&:groups).flatten, themes.map(&:groups).flatten].flatten.compact.uniq

    groups.each do |group|
      n = rand(3)
      user.likes << if n.zero?
                      group
                    elsif n == 1
                      group.releases.to_a.sample
                    else
                      group.artists.to_a.sample
                    end
    end

    # Dislikes
    genres = Graph::Genre.all.to_a.sample(rand(1..3))

    groups = genres.map(&:groups).flatten.uniq

    groups.each do |group|
      n = rand(3)
      user.dislikes << if n.zero?
                         group
                       elsif n == 1
                         group.releases.to_a.sample
                       else
                         group.artists.to_a.sample
                       end
    end

    user.save!
  end
end
