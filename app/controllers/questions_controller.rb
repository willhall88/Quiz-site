class QuestionsController < ApplicationController

  def index
    @questions = Question.next_question
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.create(params[:question].permit(:question, :answer))
    redirect_to '/questions'
  end

end
