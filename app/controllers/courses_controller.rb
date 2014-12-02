class CoursesController < ApplicationController
	layout "nav_amt"
	def index
		if !signed_in?
			redirect_to(new_user_session_path)
		end
		@specific_js = ["highcharts/all_courses.js", "highcharts.js"]
		
	end

	def my_courses
		@courses = current_user.courses
		
		@title = "Mis cursos"
		render 'courses'
	end

	def all_courses
		@courses = Course.all
		@title = "Todos los cursos"
		render 'courses'
	end

	def show
		@course = Course.find(params[:id])
		@hours_per_day = Course.hours_per_day(@course)
		@hours_per_week = Course.hours_per_week(@hours_per_day)
		@percent_per_week = Course.percent_per_week(@hours_per_week,@course.estimated_hours).to_i
		

	end

	def new
		@course = Course.new
		@action = "Crear curso..."
	end

	def create
		@course = Course.create(course_params)
		@course.users.push(current_user)
		if @course.save
			flash[:notice] = "Felicidades, tu curso ha sido creado."
			redirect_to(my_courses_path) 
		else
			@errors	= @course.errors.full_messages
			flash[:error] = "Lo siento, no se ha podido crear tu curso"
        render 'new'
		end			
	end

	def edit
		@course = Course.find(params[:id])
		@action = "Editar..."
	end

	def update
		@course = Course.find(params[:id])
		@course.update_attributes(course_params)

		if @course.update_attributes(course_params)
			redirect_to(my_courses_path)
		else
			@errors	= @course.errors.full_messages
			flash[:error] = "Lo siento, no se ha podido editar tu curso"
      render 'edit'
    end
	end

	def destroy
		@course = Course.find(params[:id])
		if @course.destroy
			redirect_to(my_courses_path)
		else
			@errors	= @course.errors.full_messages
			flash[:error] = "Lo siento, no se ha podido borrar tu curso"
		end
	end

	private
	def course_params
		params.require(:course).permit(:id, :name, :estimated_hours, :start_date, :end_date, :description, :platform)
	end

	def course_id_params
		params.require(:course).permit(:id)
	end
end
