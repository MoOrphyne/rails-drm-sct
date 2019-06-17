class ReviewsController < ApplicationController
  def new
  end

  def create
    @review = Review.new(review_params)
    @review.update(pack: Pack.find(params[:pack_id]), user: current_user)
    authorize @review
    if @review.save
      redirect_to pack_path(@review.pack)
    else
      render 'packs/show'
    end
  end

  def destroy
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
