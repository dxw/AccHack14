module ApplicationHelper
	def cp(path)
	  "active" if request.path.eql?(path)
	end

  def try_percentage(value)
    if value.present?
      number_to_percentage(value, precision: 2)
    else
      content_tag :em, "No data"
    end
  end
end