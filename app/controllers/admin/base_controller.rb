class Admin::BaseController < ApplicationController
	before_action :authenticate_user_admin

	def authenticate_user_admin
		unless current_user.admin?
			raise "You are Not Authorized to View this page"
		end
	end
end
