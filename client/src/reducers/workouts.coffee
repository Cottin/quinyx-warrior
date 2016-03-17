{URL_SET_QUERY, WORKOUT_GET} = require '../constants/ActionTypes'
{type} = require 'ramda' #auto_require:ramda
{cc, maxIn} = require 'ramda-extras'

workouts = (state = [], action) ->
	{status, ts, error, type, data} = action
	switch type
		when WORKOUT_GET
			switch status
				when 'success'
					data
				else
					state
		else
			state

module.exports = workouts
