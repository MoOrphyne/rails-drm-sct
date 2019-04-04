class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @last_packs = Pack.order('created_at DESC').first(4)
    @slots = 500 - User.where(subscriber: true).count
  end
end
