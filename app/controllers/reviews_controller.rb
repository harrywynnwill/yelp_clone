class ReviewsController < ApplicationController
before_action :authenticate_user!

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end
  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review =  @restaurant.reviews.build_with_user(review_params, current_user)

    # if current_user.has_reviewed(@restaurant)
    if @review.save
      redirect_to restaurants_path
    else
      if @review.errors[:user]
        redirect_to restaurants_path alert: 'You have already reviewed this restaurant'
      else
        render :new
      end
    end
  end
  # def show
  #   @restaurant = @restaurant.reviews.find(params[:restaurant_id])
  # end
  private

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

end
