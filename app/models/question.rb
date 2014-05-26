class Question < ActiveRecord::Base
  has_many :answers

  def self.next_question
    questions = Question.all.reject {|question| Answer.all.map {|answer| question.id == answer.question_id}.any? }
    questions.first
  end
end
