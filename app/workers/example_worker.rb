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
    raise 'Not implemented yet'
  end


  ### Attributes ###
  def myattribute
    Array(@mydatasource.myattribute)
  end

  def myotherattribute
    Array(@mydatasource.myotherattribute)
  end

  ### Associations ###
  def myassociation
    @object.myassociation.delete_all
    (@mydatasource.myassociation + @myotherdatasource.myassociation).each do |myassoc|
      @object.myassociation << MyAssociation.new(myassoc)
    end
  end
end
