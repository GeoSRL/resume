module ApplicationHelper

	def logged_in?
		return session[:user]
	end

end
