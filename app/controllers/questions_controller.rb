class QuestionsController < ApplicationController
  def update
    # reciving the given and filtered data
    question_params = update_question_params

    # finding the selected question (selected via :id parameter in the URL)
    target_question = Question.find_by(id: params[:id])

    # checking if the current user is the owner of the target question 
    if @current_user.id == target_question.user_id
      # checking if updating the target_question is possible with the given data and informing the client of the results
      if target_question.update(update_question_params)
        render json: { message: 'OK'}
      else
        render json: { message: 'NOT_OK', error: target_question.errors }
      end
    end
  end

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
  
  def update_question_params
    params.permit(:title, :tags, :body)
  end
end
