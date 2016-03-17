types = require '../constants/ActionTypes'
dataApi = require '../api/dataApi'
setQuery = (query) -> {type: types.URL_SET_QUERY, query}

workoutGetRequest = (ts) -> {type: types.WORKOUT_GET, ts}
workoutGetSuccess = (ts, data) ->
	{type: types.WORKOUT_GET, ts, status: 'success', data}
workoutGetError = (ts, error) ->
	{type: types.WORKOUT_GET, ts, status: 'error', error}
workoutAll = -> (dispatch) ->
	# hi-resolution timestamp
	# http://stackoverflow.com/questions/20120562/javascript-timestamp-number-is-not-unique
	ts = performance.now()
	dispatch workoutGetRequest(ts)

	dataApi.getWorkouts()
		.then (data) ->
			dispatch workoutGetSuccess(ts, data)
		.catch (error) ->
			dispatch workoutGetError(ts, error)

userGetRequest = (ts) -> {type: types.USER_GET, ts}
userGetSuccess = (ts, data) ->
	{type: types.USER_GET, ts, status: 'success', data}
userGetError = (ts, error) ->
	{type: types.USER_GET, ts, status: 'error', error}
userAll = -> (dispatch) ->
	# hi-resolution timestamp
	# http://stackoverflow.com/questions/20120562/javascript-timestamp-number-is-not-unique
	ts = performance.now()
	dispatch userGetRequest(ts)

	dataApi.getUsers()
		.then (data) ->
			dispatch userGetSuccess(ts, data)
		.catch (error) ->
			dispatch userGetError(ts, error)

module.exports = {setQuery, workoutGetRequest, workoutGetSuccess,
workoutGetError, workoutAll,
userGetRequest, userGetSuccess, userGetError, userAll}
