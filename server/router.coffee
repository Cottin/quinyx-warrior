util = require 'util'
assert = require 'assert'
{dropLast, map} = require 'ramda' # auto_require:ramda
{cc, ccp, dropLast, isa} = require 'ramda-extras'
GoogleSpreadsheet = require 'google-spreadsheet'
# sheet = new GoogleSpreadsheet '1a1584pE76EXlqkbaT7KI85GzAIxAbv-TEccoiX8SROc'
q = require 'q'
users = require './users'

routerHelpers = require './helpers/routerHelpers'

extractReport = (row) ->
	ts: row.timestamp
	email: row.username
	date: row.dateforrepsandsteps
	steps: parseInt(row.steps)
	crunches: parseInt(row.crunches)
	pushups: parseInt(row.pushups)
	pullups: parseInt(row.pullups)


router = (app, config) ->
	{routeDefinitions, group, get, put, post, del} = routerHelpers(app)
	g = group
	sheet = new GoogleSpreadsheet config.document_id

	routeDefinitions null,
		g 'reports',
			get ->
				def = q.defer()
				sheet.useServiceAccountAuth config.google_creds, (err) ->
					# getInfo returns info about the sheet and an array or "worksheet" objects
					# sheet.getInfo (err, sheet_info) ->
					# 	console.log sheet_info.title + ' is loaded' 
					sheet.getRows 6, (err, row_data) ->
						if err then deferred.reject err
						else def.resolve map(extractReport, row_data)
				return def.promise
		g 'users',
			get -> users

module.exports = router
