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
    @pack.infos = "#{params[:infos].join(',')},"
    authorize :pack, :create?
    if @pack.save
      create_user_packs(@pack)
      redirect_to '/admin'
      flash[:notice] = "Pack successfully created"
    else
      render :new
    end
  end

  def edit
    authorize @pack
  end

  def update
    @pack.update(pack_params)
    authorize @pack
  end

  def destroy
    authorize @pack
    @pack.destroy
    redirect_to admin_packs_path
  end

  def new_user_pack
    authorize :pack, :new_user_pack?
    @packs = Pack.all
    @users = User.all
  end

  def gift
    authorize :pack, :gift?
    @pack = Pack.find_by_title(params[:gift][:pack])

    if params[:gift][:user] == 'All Subs'
      create_user_packs(@pack)
    else
      @user = User.find_by_email(params[:gift][:user])
      UserPack.create(user_id: @user.id, pack_id: @pack.id)
    end

    redirect_to admin_packs_path
  end

  private

  def create_user_packs(pack)
    User.where(subscriber: true).each do |user|
      UserPack.create(user_id: user.id, pack_id: pack.id)
      user.send_new_pack_email(pack)
    end
  end

  def set_pack
    @pack = Pack.find(params[:id])
  end

  def pack_params
    params.require(:pack).permit(:title, :description, :photo, :price, :genre, :file, :infos)
  end

end
