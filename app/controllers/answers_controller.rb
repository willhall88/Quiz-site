class AnswersController < ApplicationController

  def create
    @question = Question.find(params[:question_id])
    @correct_answer = (@question.answer.to_s == params[:guess])
    @answer = @question.answers.create(:answer => @correct_answer)
    redirect_to('/questions')
  end
end
