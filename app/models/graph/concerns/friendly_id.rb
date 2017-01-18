module Graph
module Concerns
  ##
  # Allow pretty URLs
  #
  module FriendlyId
    def self.included(base)
      base.send :extend, ClassMethods

      def generate_friendly_id(candidate_syms)
        candidates = []

        candidate_syms.each do |candidate_sym|
          if self.class.attributes.include? candidate_sym
            candidates << self[candidate_sym].parameterize if self[candidate_sym]
          else
            if self[candidate_sym]
              self[candidate_sym].each do |candidate|
                candidates << candidate.to_s.parameterize if candidate
              end
            end
          end
        end

        candidate_id = ''

        candidates.each do |candidate|
          candidate_id << candidate
          unless self.class.find_by_friendly_id(candidate_id)
            self[:friendly_id] = candidate_id
            return
          end
        end

        raise Headbanger::NoSlugAvailable
      end
    end

    module ClassMethods
      ##
      # Define attributes to use as friendly id candidates
      #
      def friendly_id_candidates(*candidate_syms)
        # Don't forget to use migrations to add an index on :friendly_id when using this concern
        property :friendly_id

        validates :friendly_id,
                              :presence => true

        before_validation -> { generate_friendly_id candidate_syms }

        def find_by_friendly_id(friendly_id)
          find_by :friendly_id => friendly_id
        end
      end
    end
  end
end
end
