module ApplicationHelper
  def sortable(column, title=nil)
    title ||= column.titleize
    direction = (column == params[:sort] && (params[:direction] == 'asc')? 'desc' : 'asc')
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

  def flash_class(level)
    case level
        when :alert then "alert alert-danger"
        when :danger then "alert alert-danger"
        when :error then "alert alert-danger"
        when :notice then "alert alert-info"
        when :success then "alert alert-success"
    end
  end
end
