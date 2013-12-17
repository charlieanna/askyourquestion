@QuestionsCtrl = ["$scope","$window","$http","fromoutside", ($scope,$window, $http,$fromoutside) ->
  $window.channel.bind "my_event", (data) ->
    console.log(data)
    question = data.question.question
    $scope.questions.push question
    $scope.$digest()
  
  $scope.questions = []
  $scope.predicate = '-votes'
  $scope.addQuestion = ->
    question = {body:$scope.question.body;votes:parseInt($scope.question.votes)}
    console.log question
    $scope.questions.push(question)
    $scope.question = ""
  $scope.up = (question) ->
    $.ajax(
      url: "/questions/"+question.id+"/vote"
      type: "post"
      dataType:'json'
      data:
        _method: "create"
    ).done (data) ->
      ind = $scope.questions.indexOf(question)
      question = data.question
      $scope.questions[ind] = question
      $scope.$digest()
   
        
  $scope.down = (question) ->
   $.ajax(
      url: "/questions/"+question.id+"/vote"
      type: "post"
      dataType:'json'
      data:
        _method: "delete"
    ).done (data)->
      ind = $scope.questions.indexOf(question)
      question = data.question
      $scope.questions[ind] = question
      $scope.$digest()
   
    
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