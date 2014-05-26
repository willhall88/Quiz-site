class QuestionsController < ApplicationController

  before_action :authenticate_user!

  def index
    @question = Question.next_question
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.create(params[:question].permit(:question, :answer))
    redirect_to '/questions'
  end

end
