{USER_GET} = require '../constants/ActionTypes'
{fromPairs, map, type} = require 'ramda' #auto_require:ramda

users = (state = {}, action) ->
	{status, error, type, data} = action
	switch type
		when USER_GET
			switch status
				when 'success'
					extract = ({email, imageUrl}) -> [email, {email, imageUrl}]
					cc fromPairs, map(extract), data
				else
					state
		else
			state

module.exports = users
