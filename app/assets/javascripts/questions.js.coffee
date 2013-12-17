@QuestionsCtrl = ["$scope","$http", ($scope, $http) ->
  $scope.questions = []
  $scope.predicate = '-votes'
  $scope.addQuestion = ->
    question = {body:$scope.question.body;votes:parseInt($scope.question.votes)}
    console.log question
    $scope.questions.push(question)
    $scope.question = ""
  $scope.up = (question) ->
    question.liked = true
    $.ajax
      url: "/questions/"+question.id+"/vote"
      type: "post"
      dataType: "json"
      data:
        _method: "create"
  $scope.down = (question) ->
    # alert $scope.questions.indexOf(question)
    question.liked = false
    # $scope.questions[$scope.questions.indexOf(question)] = question
    $.ajax
      url: "/questions/"+question.id+"/vote"
      type: "post"
      data:
        _method: "delete"
    
  $scope.get = ->
    
    url = "/questions.json"
    $http(
      method: "GET"
      url: url
    ).success((rdata, status, headers, config) ->
      console.log rdata
      $scope.questions = rdata.questions
      
    ).error (data, status, headers, config) ->
]