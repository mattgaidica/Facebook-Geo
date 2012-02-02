class PagesController < ApplicationController
  def index
  end

  def sms
    if current_user
      body = "Share your location with Adrian College GEO http://facebookgeo.herokuapp.com/locate/" + current_user.uid
      Twilio::SMS.create  :to => params[:number], 
                          :from => '6502654544',
                          :body => body
      flash[:message] = "A link has been sent to your phone so you can update your location."
      redirect_to root_path
    end
  end

  def locate
    @locate_user = User.find_by_uid(params[:uid])
  end

end
