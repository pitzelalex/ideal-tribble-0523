class StudiosController < ApplicationController
  def index
    @studios = Studio.all
  end
  
  def show
    @studio = Studio.find(params[:id])
    @actors = @studio.all_actors
  end
end
