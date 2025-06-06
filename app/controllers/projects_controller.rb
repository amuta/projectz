class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update change_status]

  def index
    @projects = Project.all
  end

  def show
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to @project, notice: "Project created"
    else
      message = @project.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity, alert: "Error creating project: #{message}"
    end
  end


  def edit; end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: "Project updated"
    else
      message = @project.errors.full_messages.join(", ")
      render :edit, status: :unprocessable_entity, alert: "Error updating project: #{message}"
    end
  end

  def change_status
    new_status = params[:project][:status]
    unless Project.statuses.key?(new_status)
      return head :unprocessable_entity
    end

    old_status = @project.status
    if @project.update(status: new_status)
      @project.change_logs.create!(
        user: Current.user,
        changed_data: { from: old_status, to: @project.status }
        )
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @project, notice: "Status updated" }
      end
    else
      message = @project.errors.full_messages.join(", ")
      head :unprocessable_entity, alert: "Error updating status: #{message}"
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description, :status)
  end
end
