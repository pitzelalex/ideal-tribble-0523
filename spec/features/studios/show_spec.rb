require 'rails_helper'

RSpec.describe 'studios show' do
  before :each do
    @studio1 = Studio.create!(name: 'Universal', location: 'Hollywood')
    @movie1 = @studio1.movies.create!(title: 'Jurassic Park', creation_year: 1993, genre: 'Action')
    @movie2 = @studio1.movies.create!(title: 'The Fast and the Furious', creation_year: 2001, genre: 'Crime/Thriller')
    @actor1 = @movie1.actors.create!(name: 'Jeff Goldblum', age: 70)
    @actor2 = @movie1.actors.create!(name: 'Laura Dern', age: 55)
    @actor3 = @movie1.actors.create!(name: 'Sam neill', age: 75)
    @actor4 = @movie2.actors.create!(name: 'Vin Diesel', age: 55)
    @actor5 = @movie2.actors.create!(name: 'Paul Walker', age: 50)
    @actor6 = @movie2.actors.create!(name: 'Michelle Rodriguez', age: 44)
  end
  describe 'when I visit the show page' do
    it 'lists all actors who have worked for the studio on any movie' do
      visit "/studios/#{@studio1.id}"

      expect(page).to have_content(@actor1.name)
      expect(page).to have_content(@actor2.name)
      expect(page).to have_content(@actor3.name)
      expect(page).to have_content(@actor4.name)
      expect(page).to have_content(@actor5.name)
      expect(page).to have_content(@actor6.name)
    end
  end
end
