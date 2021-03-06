
esmfamil.classy.controller
  name: 'friendsCtrl'

esmfamil.classy.controller
  name: 'friendsNewgameCtrl'

  inject: ['$scope', '$state', 'myself', 'games', 'players']

  init: ->

  newGame: ->
    man = {}
    man[@myself.id] = @myself
    @games.$add(man)
      .then (ref) =>
        @myself.game = ref.name()
        @players.$child(@myself.id).$update
          game: @myself.game
        @$state.go 'friends.invite'

esmfamil.classy.controller
  name: 'friendsInvitedCtrl'

  inject: ['$scope', 'myself', 'games']

  acceptInvite: ->
    game = @people[self].game
    @games[game][self].score = 0
    @games.$save game

esmfamil.classy.controller
  name: 'friendsInviteCtrl'

  inject: ['$scope', 'myself', 'games', 'players']

  init: ->
    @$.players = @players

  watch:
    '{object}players': (val) ->
      @$.friends = @_getOnlineFriends val
      console.log @$.friends

  _getOnlineFriends: (friends) ->
    for id in friends.$getIndex() when not friends[id].game? and id in @myself.friends
      friends[id]

  invite: (id) ->
    @people[id].game = @$.game
    @people.$save id

