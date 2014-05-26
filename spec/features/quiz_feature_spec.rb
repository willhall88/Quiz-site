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

  describe 'adding a question' do
    it 'adds it to the questions index' do
      visit '/questions/new'
      fill_in 'Question', with:'Is Paris the capital of France?'
      choose "question_answer_true"
      click_on "Add question"

      expect(current_path).to eq '/questions'
      expect(page).to have_content 'Question: Is Paris the capital of France?'
      expect(page).to have_button 'True'
      expect(page).to have_button 'False'
    end
  end

  describe 'answering a question' do
    before  do
      Question.create(question: "Is Paris the capital of France?", answer: "True")
      Question.create(question: "Is Hamburg the capital of Germany?", answer: "False")
    end
    
    specify "answering the question correctly" do
      visit '/questions'
      click_on "True"

      expect(current_path).to eq '/questions'
      expect(page).to have_content 'Question: Is Hamburg the capital of Germany?'
      expect(page).not_to have_content 'Question: Is Paris the capital of France?'
      expect(page).to have_button 'True'
      expect(page).to have_button 'False'

    end
  end
end