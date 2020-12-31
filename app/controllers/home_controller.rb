class HomeController < ApplicationController
  def index
  end
  def get_annotation
    p params
    p params[:parameters][:atids]
    a = params[:parameters][:atids]
    p a.split
  end
end
