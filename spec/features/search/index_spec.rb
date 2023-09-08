require 'rails_helper'

RSpec.feature 'SearchController', type: :feature do
  scenario 'displays member information when there are members' do
    VCR.use_cassette('fire_nation_members') do
      visit root_path
      select 'Fire Nation', from: 'nation'
      click_button 'Search For Members'
      visit search_path(nation: 'Fire Nation')
      expect(page).to have_content('Search Results')
      expect(page).to have_content('Total Members:')
      expect(page).to have_content('First 25 Members')
    end
  end

  scenario 'displays a message when there are no members' do
    VCR.use_cassette('non_existent_nation') do
      visit search_path(nation: 'Non-Existent Nation')
      expect(page).to have_content('No members found for the selected nation.')
    end
  end
end
