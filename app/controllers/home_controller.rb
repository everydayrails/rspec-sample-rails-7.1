class HomeController < ApplicationController
  before_action do
    if signed_in?
      redirect_to recipes_path
    end
  end

  def index
  end
end
