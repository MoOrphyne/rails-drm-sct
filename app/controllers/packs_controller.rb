class PacksController < ApplicationController
  before_action :set_pack, only: [:show, :download]

  def show
    authorize @pack
    @also_packs = Pack.where(genre: @pack.genre).where.not(id: @pack.id).limit(4)
  end

  def shop
    @packs = Pack.order('created_at DESC')
    authorize @packs

    if params[:query] && params[:query][:filter] != 'All'
      @packs = @packs.search_by_title_and_genre(params[:query][:filter])

      respond_to do |format|
        format.html { redirect_to shop_packs_path }
        format.js
      end
    end

  end

  def download
    authorize @pack
    @link = @pack.download_link
    current_user.send_download_email(@link, @pack)
  end

  private

  def set_pack
    @pack = Pack.find(params[:id])
  end

  def pack_params
    params.require(:pack).permit(:title, :description, :photo, :price, :genre, :file)
  end
end
