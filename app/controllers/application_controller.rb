class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # GET Request for all restaurants
  get "/restaurants" do
    restaurants = Restaurant.all
    restaurants.to_json(include: [:reviews, :favorites])
  end

  #GET Request for a specific restaurant, its reviews, and its favorites
  get "/restaurants/:id" do
    restaurant = Restaurant.find(params[:id])
    restaurant.to_json(include: [:reviews, :favorites])
  end

  
  #POST Request for a new favorite
  post '/favorites' do
    favorite = Favorite.create(
      food_name: params[:food_name],
      likes: params[:likes],
      restaurant_id: params[:restaurant_id]
    )
  end

  #PATCH Request for adding likes to a favorite
  patch '/favorites/:id' do
    favorite = Favorite.find(params[:id])
    favorite.update(
      likes: params[:likes],
    )
  end
  
      
  #POST request for a new review
  post '/review' do
    review = Review.create(
      username: params[:username],
      date: params[:date],
      review: params[:review],
      rating: params[:rating],
      restaurant_id: params[:restaurant_id]
    )
  end

  #PATCH Request for a review
  patch '/review/:id' do
    review = Review.find(params[:id])
    review.update(
      date: params[:date],
      username: params[:username],
      rating: params[:rating],
      review: params[:review]
    )
    review.to_json
  end
  
  #DELETE Request for a review
  delete '/review/:id' do
    review = Review.find(params[:id])
    review.destroy
    review.to_json
  end

  
end
