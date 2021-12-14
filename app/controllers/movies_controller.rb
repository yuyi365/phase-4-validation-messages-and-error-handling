class MoviesController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

  wrap_parameters false

  def index
    movies = Movie.all
    render json: movies
  end

  def create
    movie = Movie.create!(movie_params)
    render json: movie, status: :created
  end

  private

  def movie_params
    params.permit(
      :title,
      :year,
      :length,
      :director,
      :description,
      :poster_url,
      :category,
      :discount,
      :female_director,
    )
  end

  def render_unprocessable_entity(invalid)
    render json: {
             errors: invalid.record.errors.full_messages,
           },
           status: :unprocessable_entity
  end
end
