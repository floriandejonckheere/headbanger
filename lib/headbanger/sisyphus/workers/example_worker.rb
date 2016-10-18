module Headbanger
module Sisyphus
module Workers
  class ExampleWorker < BaseWorker
    def initialize; raise 'This is only an example'; end

    ### Attribute -> data source mapping ###
    attribute [:myattribute, :myotherattribute],
                :source => :mydatasource,
                :valid_for => 3.months

    association :myassociation,
                  :source => [:mydatasource, :myotherdatasource],
                  :valid_for => 3.months

    model :example

    ### Data source lookup ###
    def mydatasource(key)
      MyDataSource::Artist.find key
    end

    def myotherdatasource(key)
      raise NotImplementedError
    end


    ### Attributes ###
    def myattribute
      Array(@mydatasource.myattribute)
    end

    def myotherattribute
      Array(@mydatasource.myotherattribute)
    end

    ### Associations ###
    def myassociation(instance)
      instance.myassociation.delete_all
      (@mydatasource.myassociation + @myotherdatasource.myassociation).each do |myassoc|
        instance.myassociation << MyAssociation.new(myassoc)
      end
    end
  end
end
end
end
