class DashboardsController < ApplicationController
  def profile
    @user = current_user
    @packs = @user.packs.order('created_at DESC')
    authorize :dashboard, :profile?
  end

  def admin
    @user = current_user
    authorize :dashboard, :admin?
  end
end
