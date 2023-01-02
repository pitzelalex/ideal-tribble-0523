require 'rails_helper'

RSpec.describe 'studios index' do
  # Then I see all of the studios including name and location,
  # And under each studio I see all of the studio's movies
  # including the movie's title, creation year, and genre
  describe 'when I visit the page' do
    it 'shows all of the studios names and locations' do
      studio1 = Studio.create!(name: 'Universal', location: 'Hollywood')

      visit '/studios'

      expect(page).to have_content(studio1.name)
      expect(page).to have_content(studio1.location)
      expect(page).not_to have_content('Herne Hill')
      expect(page).not_to have_content('Toronto')

      studio2 = Studio.create!(name: 'Herne Hill', location: 'Toronto')

      visit '/studios'

      expect(page).to have_content(studio1.name)
      expect(page).to have_content(studio1.location)
      expect(page).to have_content(studio2.name)
      expect(page).to have_content(studio2.location)
    end
  end

  it 'lists all movies for each studio under each studios entry' do
    studio1 = Studio.create!(name: 'Universal', location: 'Hollywood')
    studio2 = Studio.create!(name: 'Herne Hill', location: 'Toronto')
    movie1 = studio1.movies.create!(title: 'Jurassic Park', creation_year: 1993, genre: 'Action')
    movie2 = studio1.movies.create!(title: 'The Fast and the Furious', creation_year: 2001, genre: 'Crime/Thriller')
    movie3 = studio2.movies.create!(title: 'Desert Warrior', creation_year: 2021, genre: 'Action/Adventure')

    visit '/studios'


    within "#studio-#{studio1.id}" do
      expect(page).to have_content(movie1.title)
      expect(page).to have_content(movie1.creation_year)
      expect(page).to have_content(movie1.genre)
      expect(page).to have_content(movie2.title)
      expect(page).to have_content(movie2.creation_year)
      expect(page).to have_content(movie2.genre)
    end

    within "#studio-#{studio2.id}" do
      expect(page).to have_content(movie3.title)
      expect(page).to have_content(movie3.creation_year)
      expect(page).to have_content(movie3.genre)
    end
  end
end
