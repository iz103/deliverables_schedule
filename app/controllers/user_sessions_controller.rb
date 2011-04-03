class UserSessionsController < ApplicationController
  layout "homepage"
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "logged in"
      redirect_to deliverables_url
    else
      render :action => 'new'
    end
  end

    def destroy
      @user_session = UserSession.find   #(params[:id])
      @user_session.destroy
      flash[:notice] = "Successfully logged out"
      redirect_to root_url
    end
end
