class HomepageController < ApplicationController
	def index
		if current_user.present? && current_user.admin?
			redirect_to '/admin' 
		end
	end
end
