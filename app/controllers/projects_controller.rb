class ProjectsController < ApplicationController
  def create
    if params[:existing_project_id].present?
      @project = Project.create_from_project(params[:existing_project_id])
    else
      @project = Project.new(project_params)
    end
    if @project.save
      redirect_to hackday_url(@project.hackday_id), notice: "Project successfully added"
    else
      render :new
    end
  end

  def new
    @project = Project.new
    hackday = Hackday.find params[:hackday_id]
    @projects = hackday.hackday_organization.projects.where('hackday_id != ?', hackday.id)
  end

private
  def project_params
    params.require(:project).permit(:name, :description, :hackday_id)
  end
end
