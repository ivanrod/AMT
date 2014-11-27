class CourserasController < ApplicationController
	def new
		@coursera_courses = Course.get_coursera_courses
		@my_course={}
		@coursera_courses.each do |course|
			if course['id'].to_i == params[:coursera_id].to_i
				@my_course = course 
			end
		end
    @course = Course.new(name: @my_course["name"], 
    	description: @my_course["shortDescription"], 
    	platform: "Coursera", 
    	estimated_hours: @my_course["time_estimated"].split[0].split("-")[-1],
    	start_date: Time.at(@my_course["start_date"]).to_date,
    	end_date: Time.at(@my_course["end_date"]).to_date)
    @course.users.push(current_user)
		if @course.save
			flash[:notice] = "Felicidades, tu curso ha sido creado."
			redirect_to(my_courses_path) 
		else
			@errors	= @course.errors.full_messages
			flash[:error] = "Lo siento, no se ha podido crear tu curso"
        render 'new'
		end		
    @action = "Importar curso"
  end
end
