# Monkey-patch Graph::Genre
module Graph
  class Genre
    def genre(name, &block)
      # Create a subgenre
      genre = Graph::Genre.create :name => name

      # Create associations
      self.subgenres.create genre, nil

      # Now execute the block in the previously created genre's context
      genre.instance_eval &block if block_given?
    end
  end
end

def genre(name, &block)
  # Create a genre
  genre = Graph::Genre.create :name => name

  # Now execute the block in the previously created genre's context
  genre.instance_eval &block if block_given?
end
