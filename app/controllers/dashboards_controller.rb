class DashboardsController < ApplicationController
  def profile
    @user = current_user
    @packs = @user.packs.order('created_at DESC')

    if params[:query] && params[:query][:filter] != 'All'
      @packs = @packs.search_by_title_and_genre(params[:query][:filter])

      respond_to do |format|
        format.html { redirect_to profile_path }
        format.js
      end
    end

    authorize :dashboard, :profile?
  end

  def admin
    @user = current_user
    authorize :dashboard, :admin?
  end
end
