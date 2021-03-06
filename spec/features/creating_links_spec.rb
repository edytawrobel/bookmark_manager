require 'spec_helper'
require "./app/models/link.rb"

feature 'Add link' do
  scenario 'Adds link to the database' do
    visit '/links/new'
    page.fill_in :url, :with => 'http://google.com'
    page.fill_in :title, :with => 'Google'
    click_button "Submit"
    visit '/links'
    expect(page).to have_content('Google')
  end

  scenario 'adding tags to the link' do
    visit '/links/new'
    page.fill_in :url, :with => 'http://google.com'
    page.fill_in :title, :with => 'Google'
    page.fill_in :tag, :with => 'Search'
    click_button 'Submit'
    visit '/links'
    expect(page).to have_content('Search')
  end

  scenario 'adding multiple tags to the link' do
    visit '/links/new'
    page.fill_in :url, :with => 'http://google.com'
    page.fill_in :title, :with => 'Google'
    page.fill_in :tag, :with => 'Search, Bubbles'
    click_button 'Submit'
    visit '/links'
    tags = Link.first.tags.map(&:name)
    expect(tags).to include('Search')
    expect(tags).to include('Bubbles')

  end
end
