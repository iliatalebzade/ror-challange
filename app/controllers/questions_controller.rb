class QuestionsController < ApplicationController
  
  def create
    # reciving the given and filtered data
    recived_data = create_question_params

    # create a new instance of a question with the given data and the user's id (which was provided by the authorization token)
    new_question = Question.new(title: params[:title], body: params[:body], tags: params[:tags], user_id: @current_user[:id])
    
    # checking if the title is either blank or nil (making sure that it's present)
    if new_question.title.blank?
      render json: { message: 'NOT_OK', error: 'Title not present' }
    elsif new_question.save
      # sending back the question_id after successfully creating and saving it
      render json: { message: 'OK', question_id: new_question.id }
    end
  end

  private
  def create_question_params
    params.permit(:title, :tags, :body)
  end
end
