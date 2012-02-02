class PagesController < ApplicationController
  def index
    two_hours = Time.current - 2.hours
    @positions = Position.order("updated_at").where("updated_at > '#{two_hours}'")
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

  def update
    @position = Position.find_by_uid(params[:uid])
    if @position.nil?
      @position = Position.new()
      @position.uid = params[:uid]
    end
    @position.latitude = params[:latitude]
    @position.longitude = params[:longitude]
    @position.updated_at = Time.now
    @position.save

    location = { :latitude => params[:latitude], :longitude => params[:longitude] }
    two_hours = Time.current - 2.hours
    @positions = Position.order("updated_at").where("updated_at > '#{two_hours}'")
    content = render_to_string(:partial => "pages/list_user")
    user = User.find_by_uid(params[:uid])
    Pusher['adrian_geo'].trigger('new_location', {
      :content => content,
      :location => location,
      :user => user
    })
    redirect_to root_path
  end

end
