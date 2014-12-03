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
		redirect_to myProfile_path
	end


	def user_params
	  params.require(:user).permit(:avatar, :avatar_file_name)
	end
end
