module UsersHelper

	def current_user
		return session[:user][:email]
	end

end
