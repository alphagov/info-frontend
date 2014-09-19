module ApplicationHelper
  def human_readable_number(size)
    if size > 0 && size < 1
      "< 1"
    else
      number_to_human(size, units: {thousand: "k", million: "m"}, format: "%n%u")
    end
  end
end
