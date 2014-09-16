module ApplicationHelper
  def formatted_traffic(size)
    if size > 0 && size < 1
      "< 1"
    else
      number_to_human(size, units: {thousand: "k", million: "m"}, format: "%n%u")
    end
  end
end
