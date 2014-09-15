TodoApp = angular.module("TodoApp", ["ngRoute", "templates"])

TodoApp.config ["$routeProvider", "$locationProvider", ($routeProvider, $locationProvider) ->
  $routeProvider
    .when '/',
      templateUrl: "index.html",
      controller: "TodosCtrl"
  .otherwise
    redirectTo: "/"

  $locationProvider.html5Mode(true).hashPrefix("#")
  
]

TodoApp.controller "TodosCtrl", ["$scope", "$http", ($scope, $http) ->
  $scope.todos = []
  $scope.getTodo = ->
    $http.get("/todos.json").success (data) ->
      console.log(data + "data")
      $scope.todos = data
  $scope.getTodo()

  $scope.addTodo = ->
    $http.post("/todos.json", $scope.todo).success (data) ->
      $scope.todos.push(data)
      $scope.todo = {}

  $scope.deleteTodo = (todo) ->
    conf = confirm "Delete this task?"
    if conf
      $http.delete("/todos/#{todo.id}.json").success (data) ->
        $scope.todos.splice($scope.todos.indexOf(todo), 1)

]

TodoApp.config ["$httpProvider", ($httpProvider)->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]