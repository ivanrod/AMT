class UsersController < ApplicationController
	before_action :authenticate_user!, only: :show

	layout "nav_amt"
	def show
		@user = current_user
	#	@user = User.find(params[:id])
	#	render 'users/show'
	end

	def edit_image
		current_user.update_attributes(user_params)
	end


	def user_params
	  params.require(:user).permit(:avatar)
	end
end
