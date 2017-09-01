class Admin::UsersController < Admin::BaseController

	def index
		@users = User.includes(:tasks).where(:role => 1)
	end
end
