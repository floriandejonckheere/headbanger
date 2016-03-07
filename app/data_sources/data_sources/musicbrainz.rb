module DataSources
  class Musicbrainz
  class << self
    def update_attributes(class_name, data_source, attrs)
      klass = MusicBrainz.const_get class_name
      model = klass.find data_source.key

      result = {}
      attrs.each do |attr|
        result[attr] = send attr, model
      end

      result
    end

    ## Lookup mapping methods
    private
      def date_of_birth(model)
        model.date_begin
      end

      def date_of_death(model)
        model.date_end unless model.date_end.future?
      end
  end
  end
end
