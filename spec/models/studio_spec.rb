require 'rails_helper'

RSpec.describe Studio do
  describe 'relationships' do
    it {should have_many :movies}
  end

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

  describe 'instance methods' do
    describe '#all_actors' do
      it 'returns all actors based on each studios movies' do
        expect(@studio1.all_actors).to eq([@actor1, @actor2, @actor3, @actor4, @actor5, @actor6])
        expect(@studio2.all_actors).to eq([@actor7, @actor8])
      end
    end
  end
end
