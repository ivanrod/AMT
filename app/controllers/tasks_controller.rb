class TasksController < ApplicationController
	layout "nav_amt"
	def index
		@tasks = Course.find().tasks
	end

	def new
		@course = Course.find(params[:course_id])
		@task = @course.tasks.new
	end

	def create
		@course = Course.find(params[:course_id])
		@task = @course.tasks.new(task_params)
		
		if @task.save
			flash[:notice] = "Felicidades, tu tarea ha sido creada."
			redirect_to(my_courses_path) 
		else
			@errors	= @task.errors.full_messages
			flash[:error] = "Lo siento, no se ha podido crear tu tarea"
        render 'new'
    end
	end

	def destroy
		@course = Course.find(params[:course_id])
		@task = Task.find(params[:id])
		if @task.destroy
			redirect_to(course_path(@course))
		else
			@errors = @course.errors.full_messages
			flash[:error] = "Lo siento, no se ha podido borrar tu curso"
		end
	end

	def task_params
		params.require(:task).permit(:name, :description, :deadline, :task_type)
	end
end
