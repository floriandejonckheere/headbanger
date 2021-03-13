# frozen_string_literal: true

module Steps
  module Artists
    class Attributes < ETL::Step
      def run(data)
        metal_archives = data.fetch(:metal_archives)

        data.merge(attributes: {
                     name: metal_archives.name,
                     alt_names: metal_archives.aliases,
                     description: metal_archives.biography.sanitize.squish,
                     born_on: metal_archives.date_of_birth,
                     died_on: metal_archives.date_of_death,
                     gender: metal_archives.gender,
                     country: metal_archives.country.alpha2,
                   })
      end
    end
  end
end
