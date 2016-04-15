class AnswersController < ApplicationController

  def create
    @question = Question.find params[:question_id]
    answer_params = params.require(:answer).permit(:body)
    @answer = Answer.new answer_params
    @answer.question = @question
    @answer.user = current_user
    if @answer.save
      redirect_to question_path(@question), notice: "Thanks for answering"
    else
      flash[:alert] = "not saved"
# This will render the show.html.erb inside views/questions
      render "/questions/show"
    end
  end

  def destroy
    question = Question.find params[:question_id]
    answer   = Answer.find params[:id]
    answer.destroy
    redirect_to question_path(question)
  end
end
