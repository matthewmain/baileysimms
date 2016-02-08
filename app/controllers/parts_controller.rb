class PartsController < ApplicationController

  def show
    @part = Part.find(params[:id])
    @omit_footer = true
  end
  
end

