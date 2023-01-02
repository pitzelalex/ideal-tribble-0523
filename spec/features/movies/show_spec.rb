# As a user,
# When I visit a movie's show page.
# I see the movie's title, creation year, and genre,
# and a list of all its actors from youngest to oldest.
# And I see the average age of all of the movie's actors

require 'rails_helper'

RSpec.describe 'movie show' do
  before :each do
    @studio1 = Studio.create!(name: 'Universal', location: 'Hollywood')
    @studio2 = Studio.create!(name: 'Herne Hill', location: 'Toronto')
    @movie1 = @studio1.movies.create!(title: 'Jurassic Park', creation_year: 1993, genre: 'Action')
    @movie2 = @studio1.movies.create!(title: 'The Fast and the Furious', creation_year: 2001, genre: 'Crime/Thriller')
    @movie3 = @studio2.movies.create!(title: 'Desert Warrior', creation_year: 2021, genre: 'Action/Adventure')
    @actor1 = @movie1.actors.create!(name: 'Jeff Goldblum', age: 70)
    @actor2 = @movie1.actors.create!(name: 'Laura Dern', age: 55)
    @actor3 = @movie1.actors.create!(name: 'Sam neill', age: 75)
    @actor4 = @movie2.actors.create!(name: 'Vin Diesel', age: 55)
    @actor5 = @movie2.actors.create!(name: 'Paul Walker', age: 50)
    @actor6 = @movie2.actors.create!(name: 'Michelle Rodriguez', age: 44)
    @actor7 = @movie3.actors.create!(name: 'Anthony Mackie', age: 44)
    @actor8 = @movie3.actors.create!(name: 'Sir Ben Kingsley', age: 79)
  end

  describe 'when I visit the show page' do
    it 'lists the movies details' do
      visit "/movies/#{@movie1.id}"
  
      expect(page).to have_content(@movie1.title)
      expect(page).to have_content(@movie1.creation_year)
      expect(page).to have_content(@movie1.genre)
    end
  end
end