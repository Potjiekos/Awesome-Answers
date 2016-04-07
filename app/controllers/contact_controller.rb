class ContactController < ApplicationController

  def new
    Rails.logger.info 
    render :new, layout: "special"
  end

  def create
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @email = params[:email]
    @message = params[:message]

  end

end
