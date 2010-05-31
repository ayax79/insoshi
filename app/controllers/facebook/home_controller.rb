class Facebook::HomeController  < ApplicationController
  layout "facebook/canvas"

  def index

    respond_to do |format|
      format.fbml
    end

  end

end
