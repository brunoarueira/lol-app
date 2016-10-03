require 'spec_helper'

describe 'Champions', vcr: { cassette_name: "league_of_legends/champions" } do
  include Capybara::DSL

  it 'list all the champions when visit the index' do
    visit '/'

    expect(page).to have_content 'League of Legends - Champions'

    expect(page).to have_css '.champion', count: 132

    expect(page).to have_content 'Varus'

    expect(page).to have_content 'Rumble'
  end

  it 'search for a champion on the search box' do
    visit '/'

    click_button 'Search'

    expect(page).to have_content 'You must need to type in a text to search'

    fill_in 'q', with: 'Leon'

    expect(page).to have_field 'Search for your champion', with: 'Leon'

    click_button 'Search'

    expect(page).to have_css '.champion', count: 1

    within '.champion-card' do
      expect(page).to have_content 'Leona'
      expect(page).to have_content 'the Radiant Dawn'
    end
  end

  it 'show champion info page with recommended items' do
    visit '/'

    click_link 'Leona'

    expect(page).to have_content 'Leona'
    expect(page).to have_content 'the Radiant Dawn'
    expect(page).to have_content 'If you would shine like a sun, first you must burn like one.'

    within 'table' do
      within 'tbody' do
        expect(page).to have_css 'tr', count: 105

        within 'tr:nth-child(3)' do
          expect(page).to have_content 'Ruby Crystal'
          expect(page).to have_content '+150 Health'
        end
      end
    end
  end
end
