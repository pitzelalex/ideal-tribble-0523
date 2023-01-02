class ActorMoviesController < ApplicationController
  def create
    movie = Movie.find(create_params[:movie_id])
    actor = Actor.find(create_params[:actor_id])
    am = ActorMovie.new(actor: actor, movie: movie)
    am.save
    redirect_to "/movies/#{create_params[:movie_id]}"
  end

  private

  def create_params
    params.permit(:movie_id, :actor_id)
  end
end
