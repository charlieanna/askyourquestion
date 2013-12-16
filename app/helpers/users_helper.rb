module UsersHelper
  def vote_button question
    if current_user.liked? question
      link_to "<i class='fa fa-thumbs-down'></i>Down".html_safe, question_vote_path(question),method: :delete,class: "btn btn-success pull-left",id:"bluebutton",remote: true
    else
      link_to "<i class='fa fa-thumbs-up'></i>Up".html_safe, question_vote_path(question),method: :post,class: "btn btn-success pull-left",id:"bluebutton",remote: true
    end
  end
  
  def approve_button question
    if question.approved?
      link_to "<i class='fa fa-thumbs-up'></i>Approve".html_safe, question_approval_path(question),method: :post,class: "btn btn-success pull-left",id:"bluebutton",remote: true
    else
      link_to "<i class='fa fa-thumbs-down'></i>Reject".html_safe, question_approval_path(question),method: :delete,class: "btn btn-success pull-left",id:"bluebutton",remote: true
    end
  end
end