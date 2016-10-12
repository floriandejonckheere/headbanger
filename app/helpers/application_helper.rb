module ApplicationHelper
  def controller?(*controller)
    controller.include? params[:controller]
  end

  def action?(*action)
    action.include? params[:action]
  end

  def id?(id)
    id == params[:id]
  end

  # Bootstrap alert classes
  def bootstrap_class_for flash_type
    {
      :success => 'alert-success',
      :error => 'alert-danger',
      :danger => 'alert-danger',
      :alert => 'alert-warning',
      :notice => 'alert-info',
      :info => 'alert-info'
    }[flash_type.to_sym] || flash_type.to_s
  end
end
