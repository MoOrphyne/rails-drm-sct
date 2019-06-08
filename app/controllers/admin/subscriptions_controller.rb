class Admin::SubscriptionsController < ApplicationController

  def new
    authorize :subscription, :new?
  end

  def create
  end

end
