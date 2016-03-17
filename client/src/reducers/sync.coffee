{URL_SET_QUERY, WORKOUT_GET} = require '../constants/ActionTypes'
{__, assoc, evolve, merge, objOf, type} = require 'ramda' #auto_require:ramda
{cc, maxIn} = require 'ramda-extras'

sync_workout = (state = {}, action) ->
	{status, ts, error, type} = action
	switch type
		when WORKOUT_GET
			switch status
				when 'success'
					evolve objOf(ts, merge(__, {status: 'success'})), state
				when 'error'
					evolve objOf(ts, merge(__, {status: 'error', error})), state
				else
					newItem = {ts, type, status: 'pending'}
					assoc ts, newItem, state
		else
			state

module.exports = {sync_workout}
