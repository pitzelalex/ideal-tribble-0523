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

      visit "/movies/#{@movie2.id}"
  
      expect(page).to have_content(@movie2.title)
      expect(page).to have_content(@movie2.creation_year)
      expect(page).to have_content(@movie2.genre)

      visit "/movies/#{@movie3.id}"
  
      expect(page).to have_content(@movie3.title)
      expect(page).to have_content(@movie3.creation_year)
      expect(page).to have_content(@movie3.genre)
    end

    it 'lists the actors in the movie based on their age' do
      visit "/movies/#{@movie1.id}"

      expect(page).to have_content(@actor1.name)
      expect(page).to have_content(@actor2.name)
      expect(page).to have_content(@actor3.name)

      expect(@actor2.name).to appear_before(@actor1.name)
      expect(@actor1.name).to appear_before(@actor3.name)

      visit "/movies/#{@movie2.id}"

      expect(page).to have_content(@actor4.name)
      expect(page).to have_content(@actor5.name)
      expect(page).to have_content(@actor6.name)

      expect(@actor6.name).to appear_before(@actor5.name)
      expect(@actor5.name).to appear_before(@actor4.name)

      visit "/movies/#{@movie3.id}"

      expect(page).to have_content(@actor7.name)
      expect(page).to have_content(@actor8.name)

      expect(@actor7.name).to appear_before(@actor8.name)
    end

    it 'lists the actors age besid their name' do
      visit "/movies/#{@movie1.id}"

      within "#actor-#{@actor1.id}" do
        expect(page).to have_content(@actor1.age)
      end
      within "#actor-#{@actor2.id}" do
        expect(page).to have_content(@actor2.age)
      end
      within "#actor-#{@actor3.id}" do
        expect(page).to have_content(@actor3.age)
      end

      visit "/movies/#{@movie2.id}"

      within "#actor-#{@actor4.id}" do
        expect(page).to have_content(@actor4.age)
      end
      within "#actor-#{@actor5.id}" do
        expect(page).to have_content(@actor5.age)
      end
      within "#actor-#{@actor6.id}" do
        expect(page).to have_content(@actor6.age)
      end
    end

    it 'does not list actors not associated with the movie' do
      actor9 = Actor.create!(name: 'Richard Attenborough', age: 100)

      visit "/movies/#{@movie1.id}"

      expect(page).not_to have_content(actor9.name)
    end

    it 'has a form to add an actor to this movie' do
      visit "/movies/#{@movie1.id}"

      expect(page).to have_content("Add an actor to this movie")
      expect(page).to have_field("id")
      expect(page).to have_selector("input[type=submit]")
    end

    it 'adds the actor to the movie' do
      actor9 = Actor.create!(name: 'Richard Attenborough', age: 100)

      visit "/movies/#{@movie1.id}"

      fill_in "id", with: actor9.id
      find("input[type=submit]").click
      expect(current_path).to eq("/movies/#{@movie1.id}")
      expect(page).to have_content(actor9.name)
    end
  end
end
