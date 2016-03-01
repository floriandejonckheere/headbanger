module ApplicationHelper
  def Virtual(obj)
    klass = Virtual.const_get obj.class.to_s.split('::').last

    klass.new obj
  end
end
