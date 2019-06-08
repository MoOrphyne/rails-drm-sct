class DashboardsController < ApplicationController
  def profile
    @user = current_user
    @packs = @user.packs.order('created_at DESC')

    if params[:query] && params[:query][:filter] != ''
      @packs = @packs.where(genre: params[:query][:filter])
    end

    authorize :dashboard, :profile?
  end

  def admin
    @user = current_user
    authorize :dashboard, :admin?
  end
end
