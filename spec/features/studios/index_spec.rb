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
end
