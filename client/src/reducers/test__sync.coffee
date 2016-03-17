assert = require 'assert'
{flip, type} = R = require 'ramda' #auto_require:ramda

{WORKOUT_GET} = require '../constants/ActionTypes'
actions = require '../actions'
{sync_workout} = require './sync'

eq = flip assert.strictEqual
deepEq = flip assert.deepEqual

MOCK = {
	1: {ts: 1, type: WORKOUT_GET, status: 'pending'}
}

describe 'reducer sync', ->
	describe 'sync_workout', ->
		describe WORKOUT_GET, ->
			it 'workoutGetRequest', ->
				res = sync_workout {}, actions.workoutGetRequest(1)
				expected = {ts: 1, status: 'pending', type: WORKOUT_GET}
				deepEq expected, res[1]

			it 'workoutGetSuccess', ->
				res = sync_workout MOCK, actions.workoutGetSuccess(1)
				expected = {ts: 1, status: 'success', type: WORKOUT_GET}
				deepEq expected, res[1]

			it 'workoutGetError', ->
				res = sync_workout MOCK, actions.workoutGetError(1, 'ops')
				expected = {ts: 1, status: 'error', type: WORKOUT_GET, error: 'ops'}
				deepEq expected, res[1]

