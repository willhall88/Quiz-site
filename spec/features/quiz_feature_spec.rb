require 'spec_helper'

describe 'quiz site ' do
  context 'when logged out' do
    context 'when landing on the homepage 'do
      it'should ask for user login' do
        visit '/questions'

        expect(page).to have_content "You need to sign in or sign up before continuing."
      end
    end
  end

  context 'when logged in' do
    before do
      user = User.create(email:"willhall88@hotmail.com", password:'12345678', password_confirmation:'12345678')
      login_as user
    end

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
  end
end

describe 'answering a question' do
  context "when logged in" do

    before  do
      user = User.create(email:"willhall88@hotmail.com", password:'12345678', password_confirmation:'12345678')
      login_as user
      @question1 = Question.create(question: "Is Paris the capital of France?", answer: "True")
      Question.create(question: "Is Hamburg the capital of Germany?", answer: "False")
    end
    
    specify "answering the question moves onto another question" do
      visit '/questions'
      click_on "True"

      expect(current_path).to eq '/questions'
      expect(page).to have_content 'Question: Is Hamburg the capital of Germany?'
      expect(page).not_to have_content 'Question: Is Paris the capital of France?'
      expect(page).to have_button 'True'
      expect(page).to have_button 'False'

    end

    specify "answering all questions means there is an end of questions message" do
      @question1.answers.create(:answer => true)
      visit '/questions'
      click_on "True"

      expect(current_path).to eq '/questions'
      expect(page).to have_content 'You have answered all available questions'
      expect(page).not_to have_content 'Question: Is Hamburg the capital of Germany?'
      expect(page).not_to have_content 'Question: Is Paris the capital of France?'
    end
  end
end