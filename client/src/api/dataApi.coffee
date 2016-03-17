{BASE_URL_DATA_API} = require 'config'

getWorkouts = -> fetch(BASE_URL_DATA_API + '/reports').then (res) ->
	if res.status >= 400 then throw new Error 'SERVER_BAD_RESPONSE'
	else res.json()

getUsers = -> fetch(BASE_URL_DATA_API + '/users').then (res) ->
	if res.status >= 400 then throw new Error 'SERVER_BAD_RESPONSE'
	else res.json()

module.exports = {getWorkouts, getUsers}
		
