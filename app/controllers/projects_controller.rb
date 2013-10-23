class ProjectsController < ApplicationController
  def create
    hackday = load_and_check_hackday
    @project = Project.create_from_project_or_new(params[:existing_project_id], project_params)
    if @project.save
      redirect_to hackday_url(@project.hackday_id), notice: "Project successfully added"
    else
      @projects = load_projects hackday
      @hardwares = hackday.hardwares
      render :new
    end
  end

  def edit
    hackday = load_and_check_hackday
    @hardwares = hackday.hardwares
    @project = Project.find params[:id]
  end

  def new
    hackday = load_and_check_hackday
    @project = Project.new
    @projects = load_projects hackday
    @hardwares = hackday.hardwares
  end

  def update
    hackday = load_and_check_hackday
    @project = Project.find params[:id]
    if @project.update_attributes(project_params)
      redirect_to hackday_url(@project.hackday_id), notice: "Project successfully updated"
    else
      @hardwares = hackday.hardwares
      render :edit
    end
  end

private
  def check_ownership(hackday)
    redirect_to hackday unless hackday.is_owner? current_user
  end

  def load_and_check_hackday
    hackday = Hackday.find params[:hackday_id] || params[:project][:hackday_id]
    check_ownership hackday
    hackday
  end

  def load_projects(hackday)
    hackday.hackday_organization.projects.where('hackday_id != ?', hackday.id)
  end

  def project_params
    params.require(:project).permit(:name, :description, :hackday_id, :hardware_ids)
  end
end
