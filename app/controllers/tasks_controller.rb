class TasksController < ApplicationController
	before_action :set_task, only:[:show, :edit, :update, :destroy]

	def index
		@q = Task.ransack(params[:q])
		if params[:q]
			@tasks = @q.result.limit(3)
		elsif params[:sort_expired]
			@tasks = Task.expired
		elsif params[:sort_priority]
			@tasks = Task.priority
		else
			@tasks = Task.default
		end
	end

	def show
	end

	def new
		@task = Task.new
	end

	def create
		@task = Task.new(task_params)
		if @task.save
			redirect_to tasks_path, notice: "作成しました。"
		else
			render :new, denger: "作成に失敗しました。"
		end
	end

	def edit
	end

	def update
		if @task.update(task_params)
			redirect_to tasks_path, notice: "更新しました。"
		else
			render :edit, denger: "更新に失敗しました。"
		end
	end

	def destroy
		@task.destroy
		redirect_to tasks_path, notice: "削除しました。"
	end

	private

	def task_params
		params.require(:task).permit(:name, :description, :expired_at, :state, :priority)
	end

	def set_task
		@task = Task.find(params[:id])
	end
end
