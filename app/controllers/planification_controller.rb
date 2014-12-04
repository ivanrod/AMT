class PlanificationController < ApplicationController
	layout "nav_amt"
	def weekly
		
	end

	def get_deadlines
		if request.xhr?
			render json: current_user.all_deadlines
		else
			render json: "Mal"
		end
	end
end
