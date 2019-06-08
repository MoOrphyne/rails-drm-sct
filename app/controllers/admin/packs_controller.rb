class Admin::PacksController < ApplicationController
  before_action :set_pack, only: [:show, :edit, :update, :destroy]

  def index
    @packs = policy_scope(Pack).order('created_at DESC')
  end

  def new
    @pack = Pack.new
    authorize :pack, :new?
  end

  def create
    @pack = Pack.new(pack_params)
    authorize :pack, :create?
    if @pack.save
      create_user_packs(@pack)
      redirect_to '/admin'
    else
      render :new
    end
  end

  def edit
  end

  def update
    @pack.update(pack_params)
  end

  def destroy
    @pack.destroy
    redirect_to admin_packs_path
  end

  def new_user_pack
    @packs = Pack.all
    @users = User.all
  end

  def gift
    @user = User.find_by_email(params[:gift][:user])
    @pack = Pack.find_by_title(params[:gift][:pack])
    UserPack.create(user_id: @user.id, pack_id: @pack.id)
    redirect_to admin_packs_path
  end

  private

  def create_user_packs(pack)
    User.where(subscriber: true).each do |user|
      UserPack.create(user_id: user.id, pack_id: pack.id)
    end
  end

  def set_pack
    @pack = Pack.find(params[:id])
  end

  def pack_params
    params.require(:pack).permit(:title, :description, :photo, :price, :genre, :audio)
  end

end
