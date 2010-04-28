class Facebook::HomeController  < ApplicationController
  layout :facebook

  def index

    respond_to do |format|
      format.fbml
    end

  end

end
