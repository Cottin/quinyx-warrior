util = require 'util'

{all, forEach, has, into, join, map, path} = R = require 'ramda' # auto_require:ramda
{isThenable} = require 'ramda-extras'

routerHelpers = (app) ->

	action = (verb, nameOrF, f = null) ->
		isName = R.is(String, nameOrF)
		f = if isName then f else nameOrF
		name = if isName then nameOrF else null
		return {verb, name, f}

	get = (nameOrF, f = null) -> action 'get', nameOrF, f
	post = (nameOrF, f = null) -> action 'post', nameOrF, f
	put = (nameOrF, f = null) -> action 'put', nameOrF, f
	del = (nameOrF, f = null) -> action 'delete', nameOrF, f
	all = (nameOrF, f = null) -> action 'all', nameOrF, f

	group = (groupName, actions...) ->
		createHandler = (a) ->
			{verb, name, f} = a
			console.log 'verb:', verb
			if verb == 'all'
				console.log 'groupName:', groupName
				console.log 'name:', name
				console.log 'f:', util.inspect(f, null)
				app[verb] '*', f
				return

			handler = (req, res) ->
				console.log 'body', req.body
				# params = map ((x)->req.body[x]), paramNames
				# console.log 'params:', params
				console.log 'req.params:', req.params
				console.log 'req.query:', req.query
				result = f.apply {req, res}, [req.body, req.params, req.query]
				console.log 'result', result
				console.log 'isThenable', isThenable result
				if isThenable result
					success = (data) ->
						if has('insertedCount', data) && has('ops', data)
							res.status(200).send data.ops[0]
						else 
							res.status(200).send data
					error = (data) -> res.status(data.statusCode)
					# todo: look into how to handle errors etc
					result.then(success).catch(error)
				else
					if result? && has('code', result) 
						res.status(result.code).send(result)
					else
						console.log 'result', result
						res.send result

			console.log 'verb:', verb, ' path:', '/'+join('/', [groupName, name])
			app[verb] '/'+join('/', [groupName, name]), handler

		console.log 'group:', groupName, ' actions:', actions
		forEach createHandler, actions

	routeDefinitions = (_, groups...) -> undefined

	return {action, get, post, put, del, all, group, routeDefinitions}

module.exports = routerHelpers
