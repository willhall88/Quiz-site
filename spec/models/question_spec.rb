require 'spec_helper'

describe 'moving onto the next question' do
  it "should be able to select the next unanswered question" do
    question1 = Question.create(question: "Is Paris the capital of France?", answer: "True")
    question2 = Question.create(question: "Is Hamburg the capital of Germany?", answer: "False")
    question3 = Question.create(question: "Is London the capital of England?", answer: "True")
    
    expect(Question.next_question.question).to eq "Is Paris the capital of France?"
    question1.answers.create(:answer => true)
    expect(Question.next_question.question).to eq "Is Hamburg the capital of Germany?"
    question2.answers.create(:answer => true)
    expect(Question.next_question.question).to eq "Is London the capital of England?"
  end
end
