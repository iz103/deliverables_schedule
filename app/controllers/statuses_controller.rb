class StatusesController < ApplicationController
  def index
    
  end

  def show
    @status = Status.find(params[:id])
  end

end
