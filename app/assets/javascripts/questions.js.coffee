@QuestionsCtrl = ["$scope","$http", ($scope, $http) ->
  $scope.questions = []
  $scope.predicate = '-votes'
  $scope.addQuestion = ->
    question = {body:$scope.question.body;votes:parseInt($scope.question.votes)}
    console.log question
    $scope.questions.push(question)
    $scope.question = ""
  $scope.up = (question) ->
    alert(question.id)
  $scope.down = (question) ->
    alert(question.id)
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