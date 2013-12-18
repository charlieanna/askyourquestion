@QuestionsCtrl = ["$scope","$window","$http","fromoutside", ($scope,$window, $http,fromoutside) ->
  $scope.questions = []
  $scope.objectFindByKey = (array, key, value) ->
    i = 0

    while i < array.length
      return array[i]  if array[i][key] is value
      i++
    null
 
  
  $scope.predicate = '-votes'
  $scope.subscribe_as_admin = (channel,isAdmin)->
    if isAdmin
      $window.pubnub.subscribe
        channel: channel+"_admin"
        message: (data) ->
          console.log data
          question = data.question.question
          if data.question? and (data.action is "add")
            $scope.questions.push question
            $scope.$digest()
          else if data.question? and (data.action is "like" or data.action is "dislike")
            obj = $scope.objectFindByKey($scope.questions,"id",question.id)
            ind = $scope.questions.indexOf(obj)
            $scope.questions[ind] = question
            $scope.$digest()
            
    else
      $window.pubnub.subscribe
        channel: channel+"_user"
        message: (data) ->
          console.log data
          question = data.question.question
          if data.question? and (data.action is "approved" or data.action is "disapproved")
            $scope.questions.push question
            $scope.$digest()
          else if data.question? and (data.action is "like" or data.action is "dislike")
            obj = $scope.objectFindByKey($scope.questions,"id",question.id)
            ind = $scope.questions.indexOf(obj)
            $scope.questions[ind] = question
            $scope.$digest()
  $scope.addQuestion = ->
    question = {body:$scope.question.body;votes:parseInt($scope.question.votes)}
    $scope.questions.push(question)
    $scope.question = ""
    
  $scope.approve = (question) ->
    $.ajax(
      url: "/questions/"+question.id+"/approve"
      type: "post"
      dataType:'json'
      data:
        _method: "create"
    ).done (data) ->
      ind = $scope.questions.indexOf(question)
      question = data.question
      $scope.questions[ind] = question
      $scope.$digest()
   
        
  $scope.reject = (question) ->
   $.ajax(
      url: "/questions/"+question.id+"/approve"
      type: "post"
      dataType:'json'
      data:
        _method: "delete"
    ).done (data)->
      ind = $scope.questions.indexOf(question)
      question = data.question
      $scope.questions[ind] = question
      $scope.$digest()
  $scope.up = (question) ->
    $.ajax(
      url: "/questions/"+question.id+"/vote"
      type: "post"
      dataType:'json'
      data:
        _method: "create"
    ).done (data) ->
      # ind = $scope.questions.indexOf(question)
 #      question = data.question
 #      $scope.questions[ind] = question
 #      $scope.$digest()
 #   
        
  $scope.down = (question) ->
   $.ajax(
      url: "/questions/"+question.id+"/vote"
      type: "post"
      dataType:'json'
      data:
        _method: "delete"
    ).done (data)->
      # ind = $scope.questions.indexOf(question)
 #      question = data.question
 #      $scope.questions[ind] = question
 #      $scope.$digest()
      
      
  
   
    
  $scope.get =  (event_id) ->
    
    url = "/events/"+event_id+"/questions.json"
    $http(
      method: "GET"
      url: url
    ).success((rdata, status, headers, config) ->
      console.log rdata
      $scope.questions = rdata.questions
      
    ).error (data, status, headers, config) ->
]