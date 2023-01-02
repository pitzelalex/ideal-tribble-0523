class Studio < ApplicationRecord
  has_many :movies
  def all_actors
    Actor.joins(:movies).where(movies: { studio_id: self.id }).distinct
  end
end
