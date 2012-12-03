module ApplicationHelper
  def format_date(date)
    date.strftime("%a, %e %b %Y")
  end
end
