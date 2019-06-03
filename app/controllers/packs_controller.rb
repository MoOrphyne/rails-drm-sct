class PacksController < ApplicationController
  before_action :set_pack, only: [:show, :download]

  def index
    @packs = Pack.order('created_at DESC')
  end

  def show
  end

  def new
    @pack = Pack.new
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
  end

  def shop
    @packs = Pack.order('created_at DESC')
  end

  def download
    @link = @pack.download_link
    current_user.send_download_email(@link, @pack)
  end

  private

  def set_pack
    @pack = Pack.find(params[:id])
  end

  def pack_params
    params.require(:pack).permit(:title, :description, :photo, :price, :genre, :audio)
  end
end
