module ApplicationHelper
	def cp(path)
	  "active" if request.path.eql?(path)
	end
end