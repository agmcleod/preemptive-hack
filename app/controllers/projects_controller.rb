class ProjectsController < ApplicationController
  def create
    @project = Project.create_from_project_or_new(params[:existing_project_id], project_params)
    if @project.save
      redirect_to hackday_url(@project.hackday_id), notice: "Project successfully added"
    else
      hackday = Hackday.find params[:hackday_id]
      @projects = load_projects hackday
      @hardwares = hackday.hardwares
      render :new
    end
  end

  def edit
    hackday = Hackday.find params[:hackday_id]
    @hardwares = hackday.hardwares
    @project = Project.find params[:id]
  end

  def new
    hackday = Hackday.find params[:hackday_id]
    @project = Project.new
    @projects = load_projects hackday
    @hardwares = hackday.hardwares
  end

  def update
    @project = Project.find params[:id]
    if @project.update_attributes(project_params)
      redirect_to hackday_url(@project.hackday_id), notice: "Project successfully updated"
    else
      hackday = Hackday.find params[:id]
      @hardwares = hackday.hardwares
      render :edit
    end
  end

private
  def load_projects(hackday)
    hackday.hackday_organization.projects.where('hackday_id != ?', hackday.id)
  end
  def project_params
    params.require(:project).permit(:name, :description, :hackday_id, :hardware_ids)
  end
end
