{createSelector} = require 'reselect'
{add, evolve, groupBy, head, init, map, merge, pluck, prop, reduce, reverse, sortBy, split, toPairs, values} = require 'ramda' #auto_require:ramda
{cc, maxIn} = require 'ramda-extras'
lo = require 'lodash'

workoutsSelector = (state) -> state.workouts
usersSelector = (state) -> state.users
orderSelector = (state) -> state.url.query.order

workoutsByUser = createSelector [workoutsSelector, orderSelector, usersSelector],
(workouts, order, users) ->
	grouped = groupBy prop('email'), workouts
	sumUp = (a, b) -> evolve
		steps: add b.steps
		crunches: add b.crunches
		pushups: add b.pushups
		pullups: add b.pullups
	, a
	init = {steps: 0, crunches: 0, pushups: 0, pullups: 0}
	summed = map reduce(sumUp, init), grouped
	addPercentage = (o) ->
		p = (o.steps / 1000000 + o.crunches / 7000 + o.pushups / 5000 + o.pullups / 3000) / 4
		merge o, {percentage: Math.round(p * 100 * 100) / 100}
	withPercentage = map addPercentage, summed
	percentageOfLeader = cc maxIn, pluck('percentage'), values, withPercentage
	addWidth = (o) -> merge o, {width: o.percentage / percentageOfLeader * 100}
	withWidth = map addWidth, withPercentage
	toObj = ([email, v]) -> merge v, {email}
	listed = cc map(toObj), toPairs, withWidth
	addName = (o) ->
		name = cc lo.capitalize, head, split('.'), o.email
		imageUrl = users[o.email].imageUrl
		merge o, {name, imageUrl}
	named = map addName, listed
	console.log 'order', order
	propToOrderBy = order || 'width'
	ordered = cc reverse, sortBy(prop(propToOrderBy)), named
	return ordered

module.exports = {workoutsByUser}

