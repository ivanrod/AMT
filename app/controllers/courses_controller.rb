class CoursesController < ApplicationController
	def index
		@courses = Course.all
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
			redirect_to(courses_path) 
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
			redirect_to(courses_path)
		else
			@errors	= @course.errors.full_messages
			flash[:error] = "Lo siento, no se ha podido editar tu curso"
      render 'edit'
    end
	end

	def destroy
		@course = Course.find(params[:id])
		if @course.destroy
			redirect_to(courses_path)
		else
			@errors	= @course.errors.full_messages
			flash[:error] = "Lo siento, no se ha podido borrar tu curso"
		end
	end

	private
	def course_params
		params.require(:course).permit(:name, :estimated_hours, :start_date, :end_date)
	end
end
