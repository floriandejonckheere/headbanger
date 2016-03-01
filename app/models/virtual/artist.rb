module Virtual
  def initialize(obj)
    puts obj
  end

  class Artist < DelegateClass(Graph::Artist)
    include Virtual::Virtualizable

    virtualize :date_of_birth,
                :source => :musicbrainz,
                :valid_for => 1.month

    priority :musicbrainz => :very_high
  end

  class HeavyMetalArtist < Artist
    priority :metal_archives => :very_high,
              :musicbrainz => :high
  end
end
