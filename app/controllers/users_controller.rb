class UsersController < ApplicationController
	before_action :authenticate_user!, only: :show

	layout "nav_amt"
	def show
	#	@user = User.find(params[:id])
	#	render 'users/show'
	end

end
