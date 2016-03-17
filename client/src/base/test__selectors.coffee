assert = require 'assert'
{flip, merge} = R = require 'ramda' #auto_require:ramda

{workoutsByUser} = require './selectors'

eq = flip assert.strictEqual
deepEq = flip assert.deepEqual

MOCK =
  workouts: [
    {
      "ts": "10/02/2016 15:05:07",
      "email": "adiola.clarke@quinyx.com",
      "date": "05/02/2016",
      "pullups": 2,
      "crunches": 7,
      "steps": 3,
      "pushups": 4,
    },
    {
      "ts": "05/02/2016 13:11:25",
      "email": "adiola.clarke@quinyx.com",
      "date": "04/02/2016",
      "pullups": 0,
      "crunches": 1,
      "steps": 2,
      "pushups": 5,
    },
    {
      "ts": "11/02/2016 22:12:14",
      "email": "andreas.sjolund@quinyx.com",
      "date": "08/02/2016",
      "pullups": 3000,
      "crunches": 7000,
      "steps": 1000000,
      "pushups": 0,
    }
  ]
  users:
    'adiola.clarke@quinyx.com':
      email: 'adiola.clarke@quinyx.com'
      imageUrl: '/public/adiola.clarke.jpeg'
    'andreas.sjolund@quinyx.com':
      email: 'andreas.sjolund@quinyx.com'
      imageUrl: '/public/andreas.sjolund.jpeg'

describe 'selectors', ->
	describe 'workoutsByUser', ->
		it 'simple case', ->
			res = workoutsByUser merge(MOCK, {url: {query: {order: 'pushups'}}})
			expected = [
				{email: "adiola.clarke@quinyx.com", name: 'Adiola', imageUrl: '/public/adiola.clarke.jpeg',
				steps: 5, crunches: 8, pullups:2, pushups: 9,
				percentage: 0.09, width: 0.12}
				{email: "andreas.sjolund@quinyx.com", name: 'Andreas', imageUrl: '/public/andreas.sjolund.jpeg',
				steps: 1000000, crunches: 7000, pullups: 3000, pushups: 0,
				percentage: 75, width: 100}
			]
			deepEq expected, res

