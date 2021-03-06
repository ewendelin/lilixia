require 'json'
class Api::V1::ReviewsController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token

  def index
    restaurant = Restaurant.find(params[:restaurant_id])
    @reviews = Review.where(restaurant_id: restaurant.id)
  end

  def create
    @review = Review.create(review_params)
    # user = User.find(params[:user_id])
    # @review = user.reviews.new(review_params)
    # @review.restaurant = Restaurant.find(params[:restaurant_id])
    # @review.save

    if @review.save
      render json: @review
    else
      render_error
    end
  end

  def review_params
    params.require(:review).permit(:user_id, :restaurant_id, :rating, :content, :avatar_url, :nickname, :image)
  end
end
