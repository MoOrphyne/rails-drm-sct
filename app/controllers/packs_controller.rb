class PacksController < ApplicationController
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
    @pack.save

    @users = User.where(subscriber: true)
    @users.each do |user|
      @user_pack = UserPack.create(user_id: user.id, pack_id: @pack.id)
    end
    redirect_to '/admin'
  end

  private

  def pack_params
    params.require(:pack).permit(:title, :description, :photo, :price)
  end
end
