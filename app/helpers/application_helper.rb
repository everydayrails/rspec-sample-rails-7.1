module ApplicationHelper
  def alert_class(flash_type)
    case flash_type.to_sym
    when :success
      "success"
    when :error, :alert
      "danger"
    when :notice
      "info"
    else
      "warning"
    end
  end
end
