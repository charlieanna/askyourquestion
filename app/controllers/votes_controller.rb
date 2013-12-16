class VotesController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    event = question.event
    old_votes = question.votes.up.count
    current_user.like question
    new_votes = question.votes.up.count
    questions = event.questions
    questions = questions.sort!{|a,b| a.votes.up.count <=> b.votes.up.count}.reverse!
    votes = questions.map { |q| q.votes.up.count }
    @old_index = votes.index(old_votes)
    @id = "question_#{@question.id}"
    if new_votes > votes[-1]
      @new_index = 0
    else
      @new_index = insert_index(new_votes,votes)
    end
    alert_client(event)
  end
  
  def destroy
    @question = Question.find(params[:question_id])
    event = question.event
    old_votes = question.votes.up.count
    current_user.dislike question
    new_votes = question.votes.up.count
    questions = event.questions
    questions = questions.sort!{|a,b| a.votes.up.count <=> b.votes.up.count}.reverse!
    votes = questions.map { |q| q.votes.up.count }
    @old_index = votes.index(old_votes)
    @id = "question_#{@question.id}"
    if new_votes < votes[0]
      @new_index = -1
    else
      @new_index = dinsert_index(new_votes,votes)
    end
    alert_client(event)
  end
  
  private
  
  def question
     @_question ||= Question.find(params[:question_id])
  end
  
  def alert_client(event)
    Pusher['test_channel'].trigger('my_event', {
         event_id: event.id
       })
  end
  
  def insert_index(value, array)
    index = 0
    if value > array[-1]
      return array.size
    else
      array.each_with_index.map{|e, i| (value <= e) ? (index = i;puts index;break) : next}
      return index
    end
  end
  
  def dinsert_index(value, array)
    index = 0
    if value < array[0]
      return -1
    else
      array.each_with_index.map{|e, i| (value <= e) ? (index = i;puts index;break) : next}
      return index
    end
  end
end