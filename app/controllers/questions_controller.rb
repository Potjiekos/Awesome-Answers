class QuestionsController < ApplicationController

# Defining a method in as a 'before_action' will make it so that Rails executes that mathod before executing the action. This is still within the same request cycle. You can give the 'before_action' method two options: :only or :except. This will help you limit the actions which the find_question method will be executed before. In the code below 'find_question' will only be executed before: show, edit, update and destroy actions.

before_action :authenticate_user!, except: [:index, :show]
before_action(:find_question, {only: [:show, :edit, :update, :destroy]})

  def new
  # We need to define a new 'Question' object in order to be able to properly generate a form in Rails
    @question = Question.new
  end

  def create
    # @question = Question.new
    # @question.title = params[:question][:title]
    # @question.body = params[:question][:body]
    # @question.save!

# Method 2- the above may also be written as:

    # @question = Question.create({title: params[:question][:title],                                 body:  params[:question][:body]})

# Method 3 - outdated, used to work with Rails 3 SHOULD NOT BE USED
    # params[:question] looks like: {"title"=>"question from web", "body"=>"question body from web"}
    # @question = Question.create(params[:question])
    # this will throw a: ActiveModel::ForbiddenAttributesError exception

# Method 4 - using the Strong Parameters feature of rails
    @question = Question.new(question_params)
    @question.user = current_user
    if @question.save
      flash[:notice] = "Question created!"
# Long Format to redirect to the 'show' question page
      # redirect_to question_path({id: @question.id})
# Much shorter version
      redirect_to question_path(@question)
    else
      flash[:alert] = "Question didn't save!"
      render :new
      # This will render 'app/views/questions/new.html.erb' because the default in this action is to render 'app/views/questions/new.html.erb'.
    end
  end

# We receive a request such as: GET /questions/12 params[:id] will be '12'
  def show
    @answer = Answer.new
  end

  def index
    @questions = Question.all
  end

  def edit

  end

  def update

# Flash messages can be set either directly using flash[:notice] = "message" or you may also pass a ':notice' or ':alert' options to the 'redirect_to' method

    if @question.update question_params
      redirect_to question_path(@question), notice: "Question updated!"
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path
  end


  def find_question
    @question = Question.find params[:id]
  end
  def question_params
    params.require(:question).permit([:title, :body, :category_id])
  end
end
