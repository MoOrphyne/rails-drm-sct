class Admin::PacksController < ApplicationController
  before_action :set_pack, only: [:show, :download, :destroy]

  def index
    @packs = policy_scope(Pack).order('created_at DESC')
  end

  def new
    @pack = Pack.new
    authorize :pack, :new?
  end

  def create
    @pack = Pack.new(pack_params)

    if @pack.save
      @users = User.where(subscriber: true)
      @users.each do |user|
        @user_pack = UserPack.create(user_id: user.id, pack_id: @pack.id)
      end
      redirect_to '/admin'
    else
      render :new
    end
    authorize :pack, :create?
  end

  def destroy
    @pack.destroy
    redirect_to admin_packs_path
  end

  private

  def set_pack
    @pack = Pack.find(params[:id])
  end

  def pack_params
    params.require(:pack).permit(:title, :description, :photo, :price, :genre, :audio)
  end
end
