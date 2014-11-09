module ApplicationHelper
	def cp(path)
	  "active" if request.path.eql?(path)
	end

  def try_percentage(value)
    if value.present?
      number_to_percentage(value, precision: 2)
    else
      no_data
    end
  end

  def try(value)
    value || no_data
  end

  def no_data
    content_tag :em, "No data"
  end
end