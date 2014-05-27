class Question < ActiveRecord::Base
  has_many :answers

  def self.next_question
    questions = Question.all.reject {|question| Answer.all.map {|answer| question.id == answer.question_id}.any? }
    questions.first
  end

    def average_correct
    if answers.any?
      answers.average(:answers)
    else
      'N/A'
    end
  end
end
