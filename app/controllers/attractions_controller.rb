class AttractionsController < ApplicationController
  def index 
    @user = User.find(session[:user_id])
    @attractions = Attraction.all
  end

  def show
    @user = User.find(session[:user_id])
    @ride = Ride.new
    @attraction = Attraction.find(params[:id])
  end

  def new
    @attraction = Attraction.new
  end

  def edit
    @attraction = Attraction.find(params[:id])
  end

  def create
    attraction = Attraction.create(attraction_params)
    redirect_to attraction_path(attraction.id)
  end

  def update
    @attraction = Attraction.find(params[:id])

    @attraction.update(attraction_params)

    if @attraction.save
      redirect_to @attraction
    else
      render "edit"
    end
  end

  private 

  def attraction_params
    params.require(:attraction).permit(:name, :min_height, :happiness_rating, :nausea_rating, :tickets)
  end
end
