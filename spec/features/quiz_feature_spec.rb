require 'spec_helper'

describe 'quiz site ' do
  context 'no questions have been added' do
    it 'should display a message' do
      visit '/questions'
      expect(page).to have_content 'No questions yet'
    end

    it 'should have a link to add a new question' do
      visit '/questions'
      expect(page).to have_link 'Add a new question'
      click_link('Add a new question')
      expect(current_path).to eq '/questions/new'
    end
  end
end