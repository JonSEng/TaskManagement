module TaskLanesHelper
  def task_lane_style(position)
    _css = getCSSInfo()
    _page_margins = _css["page-margins"].gsub(/px$/,"").to_i
    _lane_width = _css["lane-width"].gsub(/px$/,"").to_i
    _lane_padding = _css["task-lane-padding"].gsub(/px$/,"").to_i
    _lane_spacing = 10
    return "left: #{position * (2 * _lane_padding + _lane_width + _lane_spacing) + _page_margins}px;"
  end
end
