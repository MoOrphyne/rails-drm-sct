class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @slots = 500 - User.where(subscriber: true).count
  end
end
