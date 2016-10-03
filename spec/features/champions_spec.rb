require 'spec_helper'

describe 'Champions' do
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
end
