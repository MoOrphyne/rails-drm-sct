class DashboardsController < ApplicationController
  def profile
    @user = current_user
    @packs = @user.packs.order('created_at DESC')
  end

  def admin
    @user = current_user
  end
end
